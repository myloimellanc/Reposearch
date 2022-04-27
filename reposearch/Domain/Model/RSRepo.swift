//
//  RSRepo.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation


struct RSRepo: RSDomainModel {
    let owner: String?
    let name: String?
    let description: String?
    let starCount: Int64?
}


extension SearchRepositoryResponse: RSDomainConvertible {
    func asDomain() throws -> RSRepo {
        return RSRepo(owner: self.owner?.login,
                      name: self.name,
                      description: self.description,
                      starCount: self.stargazers_count)
    }
}
