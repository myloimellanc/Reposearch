//
//  RSImageDownloader.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/28.
//

import Foundation
import RxSwift
import Alamofire
import AlamofireImage


final class RSImageDownloader {
    static let shared = RSImageDownloader()
    
    private let imageDownloader: ImageDownloader
    
    private init() {
        self.imageDownloader = ImageDownloader(session: Alamofire.Session(configuration: .default,
                                                                          startRequestsImmediately: false,
                                                                          requestQueue: .RSImageDownloader,
                                                                          serializationQueue: .RSImageDownloader),
                                               downloadPrioritization: .fifo,
                                               maximumActiveDownloads: 4,
                                               imageCache: AutoPurgingImageCache(memoryCapacity: 100_000_000,
                                                                                 preferredMemoryUsageAfterPurge: 60_000_000))
    }
    
    func clearCache() {
        self.imageDownloader.imageCache?.removeAllImages()
    }
    
    func download(url: URL) -> Single<(image: UIImage, isCached: Bool)> {
        return self.download(urlRequest: URLRequest(url: url))
    }
    
    func download(urlRequest: URLRequest) -> Single<(image: UIImage, isCached: Bool)> {
        return Single
            .create { observer in
                let imageRequest = self.imageDownloader.download(urlRequest, completion: { response in
                    switch response.result {
                    case .success(let image):
                        let isCached = (response.response == nil)
                                    && (response.data == nil)
                                    && (response.metrics == nil)
                                    && (response.serializationDuration == 0.0)
                        observer(.success((image, isCached)))
                        
                    case .failure(let error):
                        observer(.failure(error))
                    }
                })
                
                return Disposables.create {
                    if let request = imageRequest {
                        self.imageDownloader.cancelRequest(with: request)
                    }
                }
            }
            .subscribe(on: ConcurrentDispatchQueueScheduler.RSImageDownloader)
    }
}
