//
//  RSRepositoryMockup.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation
import RxSwift


final class RSRepoRepositoryMockup: RSRepository {
    
    override init() {
        super.init()
    }
}


extension RSRepoRepositoryMockup: RSRepoRepositoryInterface {
    func getRepoSearchResult(searchQuery: RSRepoSearchQuery) -> Single<RSRepoSearchResult> {
        let searchResult = RSRepoSearchResult(repos: [RSRepo(owner: "", name: "", description: "", starCount: 0)],
                                              totalCount: 1,
                                              isIncompleted: false)
        
        return .just(searchResult)
    }
}
