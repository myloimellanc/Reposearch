//
//  RSImageDownloadUseCase.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/05/01.
//

import Foundation
import RxSwift


protocol RSImageDownloadUseCaseInterface: AnyObject {
    func downloadImage(url: URL) -> Single<UIImage>
}


struct RSImageDownloadUseCaseFactory {
    static var instance: RSImageDownloadUseCaseInterface {
        return RSImageDownloadUseCase()
    }
    
    private init() {
        
    }
}


final class RSImageDownloadUseCase: RSUseCase {
    #if TEST
    override init() {
        super.init()
    }
    #else
    fileprivate override init() {
        super.init()
    }
    #endif
}


extension RSImageDownloadUseCase: RSImageDownloadUseCaseInterface {
    func downloadImage(url: URL) -> Single<UIImage> {
        return RSImageDownloader.shared.download(url: url)
            .observe(on: ConcurrentDispatchQueueScheduler.RSUseCase)
            .map { $0.image }
    }
}
