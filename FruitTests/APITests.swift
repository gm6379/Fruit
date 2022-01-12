//
//  APITests.swift
//  FruitTests
//
//  Created by George McDonnell on 10/02/2018.
//  Copyright © 2018 George McDonnell. All rights reserved.
//

import XCTest
import Mockingjay
@testable import Fruit

class APITests: XCTestCase {
    
    var dataUri: String!
    
    override func setUp() {
        super.setUp()
        
        dataUri = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
    }
    
    func testFetchingData_WithValidData() {
        let fruit = ["fruit" : [["type" : "apple", "price" : 149, "weight" : 120]]]
        stub(uri(dataUri), json(fruit))
        
        let dataExpectation = expectation(description: "fetchData")
        API.instance.fetchData { (error, fruit, loadingTime) in
            XCTAssertNotNil(fruit)
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchingData_WithInvalidData() {
        stub(uri(dataUri), json([]))
        
        let dataExpectation = expectation(description: "fetchData")
        API.instance.fetchData { (error, fruit, loadingTime) in
            XCTAssertNil(fruit)
            XCTAssert(error == "An error occurred while parsing the fruit data")
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchingData_WithServerError() {
        stub(uri(dataUri), http(500))
        
        let dataExpectation = expectation(description: "fetchData")
        API.instance.fetchData { (error, fruit, loadingTime) in
            XCTAssertNil(fruit)
            XCTAssert(error == "No data returned from server")
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchingData_WithNotFoundError() {
        stub(uri(dataUri), http(404))
        
        let dataExpectation = expectation(description: "fetchData")
        API.instance.fetchData { (error, fruit, loadingTime) in
            XCTAssertNil(fruit)
            XCTAssert(error == "No data returned from server")
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
