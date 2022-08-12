//
//  ImageSearchPerformanceTests.swift
//  NASATests
//
//  Created by Susan Kern on 8/12/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import XCTest
@testable import NASA

class ImageSearchPerformanceTests: XCTestCase {

    let timeout: TimeInterval = 10 // seconds

    func testPerformanceExample() throws {
        
        self.measure {
            let keywords = "moon"
            let expectation = expectation(description: "Images for keyword: \(keywords)")
            
            DataAccessManager.shared.searchImages(for: [keywords]) { items in
                if let items = items {
                    // Make sure we get something back
                    XCTAssert(items.count > 0)
                }
                expectation.fulfill()
            }
            
            // Wait for specified period of time for response, fail test if it does not receive one
            waitForExpectations(timeout: timeout){ error in 
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    XCTFail("Image search failed to respond within \(self.timeout) seconds")
                }
            }
        }
    }
}
