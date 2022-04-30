//
//  Scheduler+reposearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation
import RxSwift


extension DispatchQueue {
    static let RSNetwork = DispatchQueue(label: "reposearch_network", attributes: .concurrent)
    static let RSImageDownloader = DispatchQueue(label: "reposearch_image_downloader", attributes: .concurrent)
}


extension ConcurrentDispatchQueueScheduler {
    static let RSNetwork = ConcurrentDispatchQueueScheduler(queue: .RSNetwork)
    static let RSImageDownloader = ConcurrentDispatchQueueScheduler(queue: .RSImageDownloader)
}
