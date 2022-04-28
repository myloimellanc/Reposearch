//
//  RepoRepositoryTests.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/28.
//

import XCTest
import RxSwift
@testable import reposearch


class RepoRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
         
    }

    func testRepoSearchResult() throws {
        let searchQuery = RSRepoSearchQuery(query: "test",
                                            sort: .bestMatch,
                                            order: .desc,
                                            perPage: 30,
                                            page: 1)
        
        let expectation = XCTestExpectation()
        let disposable = RSRepoRepository().getRepoSearchResult(searchQuery: searchQuery)
            .subscribe(onSuccess: { searchResult in
                expectation.fulfill()
                print(123123, searchResult)
            }, onFailure: { error in
                XCTFail(error.localizedDescription)
            })
        
        defer {
            disposable.dispose()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
