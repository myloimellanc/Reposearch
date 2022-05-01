//
//  RSRepositoryMockup.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/28.
//

#if TEST

import Foundation
import RxSwift


final class RSRepoRepositoryMockup: RSRepository {
    
    override init() {
        super.init()
    }
}


extension RSRepoRepositoryMockup: RSRepoRepositoryInterface {
    func getRepoSearchResult(searchQuery: RSRepoSearchQuery) -> Single<RSRepoSearchResult> {
        let repo = RSRepo(owner: "",
                          avatarURL: "",
                          name: "",
                          description: "",
                          starCount: 0)
        let searchResult = RSRepoSearchResult(repos: [repo],
                                              totalCount: 1,
                                              hasIncompletedResults: false)
        
        return .just(searchResult)
    }
}

#endif
