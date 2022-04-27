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
    
    let repositories = BehaviorRelay<[SearchRepositoryResponse]>(value: [])
    private let searchTextUpdateEvent = PublishRelay<String>()
    
    required init() {
        super.init()
        
        self.searchTextUpdateEvent
            .asObservable()
            .withUnretained(self)
            .do(onNext: { vm, _ in vm.repositories.accept([]) })
            .debounce(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .filter { _, text in text.isEmpty != true }
            .flatMapLatest { _, text -> Observable<[SearchRepositoryResponse]> in
                return RSAPIFactory.instance.searchRepositories(query: text,
                                                                sort: .bestMatch,
                                                                order: .desc,
                                                                perPage: 30,
                                                                page: 1)
                    .asObservable()
                    .map { $0.items }
                    .catchErrorJustComplete()
            }
            .bind(to: self.repositories)
            .disposed(by: self.disposeBag)
    }
}


extension RSSearchListViewModel {
    func setSearchText(_ text: String) {
        self.searchTextUpdateEvent.accept(text)
    }
}
