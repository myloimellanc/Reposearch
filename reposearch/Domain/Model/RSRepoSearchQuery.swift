//
//  RSRepoSearchQuery.swift
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
