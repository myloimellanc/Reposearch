//
//  RSSearchOrder.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation


/// This enum is ignored if you provide RSSearchSort.bestMatch.
enum RSSearchOrder {
    case desc
    case asc
    
    var parameterValue: String {
        switch self {
        case .desc:
            return "desc"
        case .asc:
            return "asc"
        }
    }
}
