//
//  AccessedValueTest.swift
//  TemplatesTests
//
//  Created by Igor Shavlovsky on 11/29/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import XCTest
@testable import Templates

class AccessedValueTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
    }

    func doTest<T: Equatable>(originalValue: T, otherValues: [T]) {
        var lastValue = originalValue
        var value = AccessedValue<T>(value: originalValue)
        otherValues.forEach { (val) in
            let expectedResult = lastValue
            let result = value.access { (value) -> (T) in
                XCTAssert(value == lastValue)
                let current = value
                value = val
                return current
            }
            XCTAssert(expectedResult == result)
            lastValue = val
        }
        let expectedResult = lastValue
        let result = value.access { (value) -> (T) in
            XCTAssert(value == lastValue)
            return value
        }
        XCTAssert(expectedResult == result)
        
        
    }
    
    func testFloats() {
        doTest(originalValue: 50.0, otherValues: [10.0, 20.0, 300.0, 20.0, 0.0, -100])
    }
    
    func testStrings() {
        doTest(originalValue: "Hello", otherValues: ["1", "", "Check", "Text", ""])
    }

}
