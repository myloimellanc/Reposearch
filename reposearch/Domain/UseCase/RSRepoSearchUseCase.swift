//
//  RSRepoSearchUseCase.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation
import RxSwift


protocol RSRepoSearchUseCaseInterface: AnyObject {
    func searchRepos(searchQuery: RSRepoSearchQuery) -> Single<(repos: [RSRepo], totalCount: Int64, nextPageExists: Bool)>
}


struct RSRepoSearchUseCaseFactory {
    static var instance: RSRepoSearchUseCaseInterface {
        #if TEST
        return RSRepoSearchUseCaseMockup()
        #else
        return RSRepoSearchUseCase()
        #endif
    }
    
    private init() {
        
    }
}


final class RSRepoSearchUseCase: RSUseCase {
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


extension RSRepoSearchUseCase: RSRepoSearchUseCaseInterface {
    func searchRepos(searchQuery: RSRepoSearchQuery) -> Single<(repos: [RSRepo], totalCount: Int64, nextPageExists: Bool)> {
        return RSRepoRepositoryFactory.instance.getRepoSearchResult(searchQuery: searchQuery)
            .map { searchResult in
                let (quotient, remainder) = searchResult.totalCount.quotientAndRemainder(dividingBy: searchQuery.perPage)
                let lastPage = (quotient > 0)
                    ? (remainder > 0)
                        ? quotient + 1
                        : quotient
                    : 1
                
                return (searchResult.repos, searchResult.totalCount, searchQuery.page < lastPage)
            }
    }
}
