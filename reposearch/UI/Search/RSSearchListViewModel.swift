//
//  RSSearchListViewModel.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation
import RxSwift
import RxRelay


class RSSearchListViewModel: RSViewModel {
    
    enum SearchResult {
        case blank
        case searching
        case result(repos: [RSRepo], totalCount: Int64, lastPage: Int64, nextPageExists: Bool)
        case emptyResult
    }
    
    let searchResult = BehaviorRelay<RSSearchListViewModel.SearchResult>(value: .blank)
    
    let searchText = BehaviorRelay<String?>(value: nil)
    let perPage = BehaviorRelay<Int64?>(value: nil)
    
    let sort = BehaviorRelay<RSSearchSort>(value: .bestMatch)
    let order = BehaviorRelay<RSSearchOrder>(value: .desc)
    
    enum Search {
        case `default`(query: RSRepoSearchQuery?)
        case nextPage(nextQuery: RSRepoSearchQuery)
        case refresh(firstPageQuery: RSRepoSearchQuery)
    }
    
    private let searchEvent = PublishRelay<RSSearchListViewModel.Search>()
    private let nextPageRequestEvent = PublishRelay<Void>()
    private let refreshEvent = PublishRelay<Void>()
    
    let errorOccurred = PublishRelay<Error>()
    
    required init() {
        super.init()
        
        self.searchEvent
            .asObservable()
            .withUnretained(self)
            .flatMapLatest { vm, search -> Observable<RSSearchListViewModel.SearchResult> in
                switch search {
                case .default(let query):
                    guard let searchQuery = query else {
                        return .just(.blank)
                    }
                    
                    return Observable
                        .create { observer in
                            observer.onNext(.blank)
                            
                            let disposable = Single.just(())
                                .delay(.seconds(1), scheduler: MainScheduler.asyncInstance)
                                .do(onSuccess: { observer.onNext(.searching) })
                                .flatMap {
                                    RSRepoSearchUseCaseFactory.instance.searchRepos(searchQuery: searchQuery)
                                }
                                .subscribe(onSuccess: { searchResult in
                                    if searchResult.repos.isEmpty && (searchResult.nextPageExists != true) {
                                        observer.onNext(.emptyResult)
                                        
                                    } else {
                                        observer.onNext(.result(repos: searchResult.repos,
                                                                totalCount: searchResult.totalCount,
                                                                lastPage: searchQuery.page,
                                                                nextPageExists: searchResult.nextPageExists))
                                    }
                                    
                                }, onFailure: { error in
                                    observer.onError(error)
                                })
                            
                            return Disposables.create([disposable])
                        }
                        .catchErrorAndComplete { error in
                            vm.errorOccurred.accept(error)
                        }
                        
                case .nextPage(let nextQuery):
                    return RSRepoSearchUseCaseFactory.instance.searchRepos(searchQuery: nextQuery)
                        .asObservable()
                        .withLatestFrom(vm.searchResult.asObservable()) { ($1, $0) }
                        .map { currentResult, nextResult -> RSSearchListViewModel.SearchResult in
                            guard case .result(let repos, _, _, _) = currentResult else {
                                
                                // TODO: 로직 정리 필요
                                
                                return .emptyResult
                            }
                            
                            let nextRepos = repos + nextResult.repos
                            return .result(repos: nextRepos,
                                           totalCount: nextResult.totalCount,
                                           lastPage: nextQuery.page,
                                           nextPageExists: nextResult.nextPageExists)
                        }
                        .catchErrorAndComplete { error in
                            vm.errorOccurred.accept(error)
                        }
                    
                case .refresh(let firstPageQuery):
                    return RSRepoSearchUseCaseFactory.instance.searchRepos(searchQuery: firstPageQuery)
                        .asObservable()
                        .map { searchResult -> RSSearchListViewModel.SearchResult in
                            if searchResult.repos.isEmpty && (searchResult.nextPageExists != true) {
                                return .emptyResult
                                
                            } else {
                                return .result(repos: searchResult.repos,
                                               totalCount: searchResult.totalCount,
                                               lastPage: firstPageQuery.page,
                                               nextPageExists: searchResult.nextPageExists)
                            }
                        }
                        .catchErrorAndComplete { error in
                            vm.errorOccurred.accept(error)
                        }
                }
            }
            .bind(to: self.searchResult)
            .disposed(by: self.disposeBag)
        
        let firstPageSearchQuery = Observable.combineLatest(self.searchText.asObservable(),
                                                   self.perPage.asObservable(),
                                                   self.sort.asObservable(),
                                                   self.order.asObservable())
            .map { text, per, sort, order -> RSRepoSearchQuery? in
                guard let query = text, let perPage = per else {
                    return nil
                }
                
                return try? RSRepoSearchQuery(query: query,
                                              sort: sort,
                                              order: order,
                                              perPage: perPage,
                                              page: 1)
            }
            .share(replay: 1, scope: .forever)
        
        firstPageSearchQuery
            .map { .default(query: $0) }
            .bind(to: self.searchEvent)
            .disposed(by: self.disposeBag)
        
        self.nextPageRequestEvent
            .asObservable()
            .withLatestFrom(Observable.combineLatest(firstPageSearchQuery,
                                                     self.searchResult.asObservable()))
            .compactMap { query, result -> RSRepoSearchQuery? in
                guard let currentQuery = query,
                      case .result(_, _, let lastPage, let isIncompleted) = result,
                      isIncompleted else {
                    return nil
                }
                
                let nextPage = lastPage + 1
                let nextQuery = try? RSRepoSearchQuery(query: currentQuery.query,
                                                       sort: currentQuery.sort,
                                                       order: currentQuery.order,
                                                       perPage: currentQuery.perPage,
                                                       page: nextPage)
                
                return nextQuery
            }
            .map { .nextPage(nextQuery: $0) }
            .bind(to: self.searchEvent)
            .disposed(by: self.disposeBag)
        
        self.refreshEvent
            .asObservable()
            .withLatestFrom(firstPageSearchQuery)
            .compactMap { $0 }
            .map { .refresh(firstPageQuery: $0) }
            .bind(to: self.searchEvent)
            .disposed(by: self.disposeBag)
    }
}


extension RSSearchListViewModel {
    func setSearchText(_ text: String) {
        self.searchText.accept(text)
    }
    
    func setSearchSort(_ sort: RSSearchSort) {
        self.sort.accept(sort)
    }
    
    func setSearchOrder(_ order: RSSearchOrder) {
        self.order.accept(order)
    }
    
    func setPerPage(_ perPage: Int64) {
        self.perPage.accept(perPage)
    }
    
    func requestNextPage() {
        self.nextPageRequestEvent.accept(())
    }
    
    func refresh() {
        self.refreshEvent.accept(())
    }
}
