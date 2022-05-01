//
//  RSDomainConvertible.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation


protocol RSDomainConvertible {
    associatedtype DomainModel: RSDomainModel
    
    func asDomain() throws -> DomainModel
}
