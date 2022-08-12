//
//  ImageSearchTests.swift
//  ImageSearchTests
//
//  Created by Susan Kern on 8/12/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import XCTest
@testable import NASA

class ImageSearchTests: XCTestCase {
    
    let waitTime: TimeInterval = 3 // seconds

    /// Access search through URL with a valid keyword and expect at least one item to be found
    func testValidSingleWordSearch() {
        let keywords = "Earth"
        let expectation = expectation(description: "Images for keyword: \(keywords)")

        DataAccessManager.shared.searchImages(for: [keywords]) { items in
            if let items = items {
                print("📗 item count for keyword \(keywords) is \(items.count)")
                XCTAssert(items.count > 0)
            }
            expectation.fulfill()
        }
        
        // Wait for specified period of time for response, fail test if it does not receive one
        waitForExpectations(timeout: waitTime){ error in 
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Image search failed to respond within \(self.waitTime) seconds")
            }
        }
    }
    
    /// Access search through URL with multiple keywords and expect at least one item to be found
    func testValidMultipleWordSearch() {
        let keywords = "hurricane atlantic"
        let expectation = expectation(description: "Images for keywords: \(keywords)")
        let keywordsArray = keywords.components(separatedBy: " ")

        DataAccessManager.shared.searchImages(for: keywordsArray) { items in
            if let items = items {
                print("📗 item count for keywords \(keywordsArray) is \(items.count)")
                XCTAssert(items.count > 0)
            }
            expectation.fulfill()
        }
        
        // Wait for specified period of time for response, fail test if it does not receive one
        waitForExpectations(timeout: waitTime){ error in 
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Image search failed to respond within \(self.waitTime) seconds")
            }
        }
    }
    
    /// Access search through URL with an invalid keyword and expect no matches
    func testInvalidSingleWordSearch() {
        let keywords = "se4t!s"
        let expectation = expectation(description: "Images for keyword: \(keywords)")

        DataAccessManager.shared.searchImages(for: [keywords]) { items in
            if let items = items {
                print("📗 item count for keyword \(keywords) is \(items.count)")
                XCTAssert(items.count == 0)
            }
            expectation.fulfill()
        }
        
        // Wait for specified period of time for response, fail test if it does not receive one
        waitForExpectations(timeout: waitTime){ error in 
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Image search failed to respond within \(self.waitTime) seconds")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
