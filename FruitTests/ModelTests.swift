//
//  FruitTests.swift
//  FruitTests
//
//  Created by George McDonnell on 20/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Fruit

class ModelTests: XCTestCase {
    
    var appleJson: JSON?
    var missingTypeJSON: JSON?
    var missingWeightJson: JSON?
    var missingPriceJson: JSON?
    
    override func setUp() {
        super.setUp()
        
        appleJson = JSON(parseJSON: "{\n  \"fruit\" : [\n    {\n      \"type\" : \"apple\",\n      \"price\" : 149,\n      \"weight\" : 120\n    }\n  ]\n}")
        missingTypeJSON = JSON(parseJSON: "{\n  \"fruit\" :   [\n    {\n      \"price\" : 149,\n           \"weight\" : 120\n    }\n  ]\n}")
        missingWeightJson = JSON(parseJSON: "{\n  \"fruit\" : [\n    {\n      \"type\" : \"apple\",\n      \"price\" : 149}\n    ]\n}")
        missingPriceJson = JSON(parseJSON: "{\n  \"fruit\" :  [\n    {\n      \"type\" : \"apple\",\n      \"weight\" : 120\n    }\n  ]\n}")
    }
    
    func testInitialisation_WithAppleJson() {
        guard let json = appleJson else {
            XCTFail()
            return
        }
        
        guard let apple = Fruit.parse(json)?.first else {
            XCTFail()
            return
        }
        
        XCTAssert(apple.type == "Apple")
        XCTAssert(apple.price == "£1.49")
        XCTAssert(apple.weight == "0.12kg")
    }
    
    func testInitialisationFailure_WithMissingTypeJson() {
        guard let json = missingTypeJSON else {
            XCTFail()
            return
        }
        
        let apple = Fruit.parse(json)?.first
        XCTAssert(apple == nil)
    }
    
    func testInitialisationFailure_WithMissingWeightJson() {
        guard let json = missingWeightJson else {
            XCTFail()
            return
        }
        
        let apple = Fruit.parse(json)?.first
        XCTAssert(apple == nil)
    }
    
    func testInitialisationFailure_WithMissingPriceJson() {
        guard let json = missingPriceJson else {
            XCTFail()
            return
        }
        
        let apple = Fruit.parse(json)?.first
        XCTAssert(apple == nil)
    }
    
}
