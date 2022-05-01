//
//  RSRepoRepository.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation
import RxSwift


protocol RSRepoRepositoryInterface: AnyObject {
    func getRepoSearchResult(searchQuery: RSRepoSearchQuery) -> Single<RSRepoSearchResult>
}


struct RSRepoRepositoryFactory {
    static var instance: RSRepoRepositoryInterface {
        #if TEST
        return RSRepoRepositoryMockup()
        #else
        return RSRepoRepository()
        #endif
    }
    
    private init() {
        
    }
}


final class RSRepoRepository: RSRepository {
    #if TEST
    override init() {
        super.init()
    }
    #else
    fileprivate override init() {
        super.init()
    }
    #endif
}


extension RSRepoRepository: RSRepoRepositoryInterface {
    func getRepoSearchResult(searchQuery: RSRepoSearchQuery) -> Single<RSRepoSearchResult> {
        return RSAPIFactory.instance.searchRepositories(query: searchQuery.query,
                                                        sort: searchQuery.sort,
                                                        order: searchQuery.order,
                                                        perPage: searchQuery.perPage,
                                                        page: searchQuery.page)
            .observe(on: ConcurrentDispatchQueueScheduler.RSRepository)
            .map { try $0.asDomain() }
    }
}
