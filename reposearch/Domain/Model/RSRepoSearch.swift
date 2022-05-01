//
//  RSRepoSearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation


struct RSRepoSearchQuery: RSDomainModel {
    
    let query: String
    
    let sort: RSSearchSort
    let order: RSSearchOrder
    
    let perPage: Int64
    let page: Int64
    
    init(query: String,
         sort: RSSearchSort,
         order: RSSearchOrder,
         perPage: Int64,
         page: Int64) throws {
        guard (query.isEmpty != true) && (perPage > 0) && (page > 0) else {
            throw RSError.incorrectParam
        }
        
        self.query = query
        self.sort = sort
        self.order = order
        self.perPage = perPage
        self.page = page
    }
}


struct RSRepoSearchResult: RSDomainModel {
    let repos: [RSRepo]
    
    let totalCount: Int64
    let hasIncompletedResults: Bool
}


extension SearchRepositoriesResponse: RSDomainConvertible {
    func asDomain() throws -> RSRepoSearchResult {
        return RSRepoSearchResult(repos: try self.items.map { try $0.asDomain() },
                                  totalCount: self.total_count,
                                  hasIncompletedResults: self.incomplete_results)
    }
}
