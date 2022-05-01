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
    static let RSRepository = DispatchQueue(label: "reposearch_repository", attributes: .concurrent)
    static let RSUseCase = DispatchQueue(label: "reposearch_usecase", attributes: .concurrent)
}


extension ConcurrentDispatchQueueScheduler {
    static let RSNetwork = ConcurrentDispatchQueueScheduler(queue: .RSNetwork)
    static let RSImageDownloader = ConcurrentDispatchQueueScheduler(queue: .RSImageDownloader)
    static let RSRepository = ConcurrentDispatchQueueScheduler(queue: .RSRepository)
    static let RSUseCase = ConcurrentDispatchQueueScheduler(queue: .RSUseCase)
}
