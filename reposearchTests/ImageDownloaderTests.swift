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
    
    private let sampleImageURLString = "https://picsum.photos/24"
    
    private func downloadNotCachedImage() throws {
        guard let sampleImageURL = URL(string: self.sampleImageURLString) else {
            XCTFail("incorrect url")
            return
        }
        
        let downloadExpectation = XCTestExpectation(description: "Request not cached image")
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
    }
    
    private func downloadCachedImage() throws {
        guard let sampleImageURL = URL(string: self.sampleImageURLString) else {
            XCTFail("incorrect url")
            return
        }
        
        let cacheExpectation = XCTestExpectation(description: "Request cached image")
        let cacheDisposable = RSImageDownloader.shared.download(url: sampleImageURL)
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
    
    func testSampleImageDownload() throws {
        try self.downloadNotCachedImage()
        try self.downloadCachedImage()
        
        RSImageDownloader.shared.clearCache()
        try self.downloadNotCachedImage()
    }
}
