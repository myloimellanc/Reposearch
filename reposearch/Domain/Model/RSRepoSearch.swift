//
//  RSRepoSearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation


struct RSRepoSearchQuery: RSDomainModel {
    
    // TODO: Empty string is not allowed
    var query: String
    
    var sort: RSSearchSort
    var order: RSSearchOrder
    
    var perPage: Int64
    var page: Int64
}


struct RSRepoSearchResult: RSDomainModel {
    let repos: [RSRepo]
    
    let totalCount: Int64
    let isIncompleted: Bool
}


extension SearchRepositoriesResponse: RSDomainConvertible {
    func asDomain() throws -> RSRepoSearchResult {
        return RSRepoSearchResult(repos: try self.items.map { try $0.asDomain() },
                                  totalCount: self.total_count,
                                  isIncompleted: self.incomplete_results)
    }
}
