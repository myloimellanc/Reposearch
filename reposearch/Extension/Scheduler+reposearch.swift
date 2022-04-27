//
//  Scheduler+reposearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation
import RxSwift


extension ConcurrentDispatchQueueScheduler {
    static let RSNetwork = ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "reposearch_network", attributes: .concurrent))
}
