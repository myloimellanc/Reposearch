//
//  ImageDownloaderTests.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/28.
//

import XCTest
import RxSwift
@testable import reposearch


class ImageDownloaderTests: XCTestCase {
    
    override func setUpWithError() throws {
        RSImageDownloader.shared.clearCache()
    }
    
    override class func tearDown() {
        RSImageDownloader.shared.clearCache()
    }
    
    func testSampleImageDownload() throws {
        let sampleImageURLString = "https://picsum.photos/24"
        guard let sampleImageURL = URL(string: sampleImageURLString) else {
            XCTFail("incorrect url")
            return
        }
        
        let downloadExpectation = XCTestExpectation(description: "Download image not cached")
        let downloadDisposable = RSImageDownloader.shared.download(url: sampleImageURL)
            .subscribe(onSuccess: { image, isCached in
                XCTAssertFalse(isCached)
                
                downloadExpectation.fulfill()
                
            }, onFailure: { error in
                XCTFail(error.localizedDescription)
            })
        
        defer {
            downloadDisposable.dispose()
        }
        
        wait(for: [downloadExpectation], timeout: 10.0)
        
        let sampleImageURLRequest = URLRequest(url: sampleImageURL)
        
        let cacheExpectation = XCTestExpectation(description: "Download image cached")
        let cacheDisposable = RSImageDownloader.shared.download(urlRequest: sampleImageURLRequest)
            .subscribe(onSuccess: { image, isCached in
                XCTAssertTrue(isCached)
                
                cacheExpectation.fulfill()
                
            }, onFailure: { error in
                XCTFail(error.localizedDescription)
            })
        
        defer {
            cacheDisposable.dispose()
        }
        
        wait(for: [cacheExpectation], timeout: 2.0)
    }
}
