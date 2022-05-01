//
//  RSError.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation


enum RSError: LocalizedError {
    case `default`(String)
    case http(Int)
    
    case incorrectParam
    
    var errorDescription: String? {
        switch self {
        case .default(let message):
            return message
            
        case .http(let statusCode):
            return "HTTP Error occurred: \(statusCode)"
            
        case .incorrectParam:
            return "Incorrect param input"
        }
    }
}
