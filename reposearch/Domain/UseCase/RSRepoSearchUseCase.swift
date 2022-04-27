//
//  RSRepoSearchUseCase.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation
import RxSwift


class RSRepoSearchUseCase: RSUseCase {
    func searchRepos(searchQuery: RSRepoSearchQuery) -> Single<(repos: [RSRepo], isIncompleted: Bool)> {
        return RSAPIFactory.instance.searchRepositories(query: searchQuery.query,
                                                        sort: searchQuery.sort,
                                                        order: searchQuery.order,
                                                        perPage: searchQuery.perPage,
                                                        page: searchQuery.page)
            .map { response in
                let repos = try response.items.map { try $0.asDomain() }
                let isIncompleted = response.incomplete_results
                
                return (repos, isIncompleted)
            }
    }
}
