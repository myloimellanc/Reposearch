//
//  RSSearchSort.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation


enum RSSearchSort {
    case bestMatch
    case stars
    case forks
    case helpWantedIssues
    case updated
    
    var parameterValue: String? {
        switch self {
        case .bestMatch:
            return nil
        case .stars:
            return "stars"
        case .forks:
            return "forks"
        case .helpWantedIssues:
            return "help-wanted-issues"
        case .updated:
            return "updated"
        }
    }
}
