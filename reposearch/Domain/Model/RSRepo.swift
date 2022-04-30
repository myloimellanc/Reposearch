//
//  RSRepo.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation


struct RSRepo: RSDomainModel {
    let owner: String?
    let avatarURL: String?
    let name: String?
    let description: String?
    let starCount: Int64?
}


extension SearchRepositoryResponse: RSDomainConvertible {
    func asDomain() throws -> RSRepo {
        return RSRepo(owner: self.owner?.login,
                      avatarURL: self.owner?.avatar_url,
                      name: self.name,
                      description: self.description,
                      starCount: self.stargazers_count)
    }
}
