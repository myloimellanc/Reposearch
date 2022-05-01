//
//  RSSearchContainerViewModel.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation
import RxSwift
import RxRelay


class RSSearchContainerViewModel: RSViewModel {
    
    let searchSorts: [RSSearchSort] = [.bestMatch, .stars, .forks, .helpWantedIssues, .updated]
    let perPages: [Int64] = [15, 30, 50]
}
