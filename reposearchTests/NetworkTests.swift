//
//  NetworkTests.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/26.
//

import XCTest
@testable import reposearch


class NetworkTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testGetURLRequest() throws {
        var responseData: Data?
        let expectation = XCTestExpectation()
        
        let disposable = RSNetwork.shared.urlRequest("https://httpbin.org/get", .get, parameters: nil, headers: nil)
            .subscribe(onSuccess: { data in
                responseData = data
                expectation.fulfill()
                
            }, onFailure: { error in
                XCTFail(error.localizedDescription)
            })
        
        defer {
            disposable.dispose()
        }
        
        wait(for: [expectation], timeout: RSNetworkTimeoutInterval)
        XCTAssertNotNil(responseData)
    }
}
