//
//  RSUseCaseMockup.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation
import RxSwift


final class RSRepoSearchUseCaseMockup: RSUseCase {
    
    override init() {
        super.init()
    }
}


extension RSRepoSearchUseCaseMockup: RSRepoSearchUseCaseInterface {
    func searchRepos(searchQuery: RSRepoSearchQuery) -> Single<(repos: [RSRepo], isIncompleted: Bool)> {
        return .just(([RSRepo(owner: "", name: "", description: "", starCount: 0)], false))
    }
}
