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
    
    func asyncAccessTest(count: Int, accessStrategy: ValueAccessStrategy, expectMatch: Bool) {
        var value = AccessedValue<Int>(value: 0, accessStrategy: accessStrategy)
        var sum: Int = 0
        var rands = [Int]()
        for _ in (1...count) {
            let rand = Int.random(in: Range<Int>(uncheckedBounds: (0, 100)))
            rands.append(rand)
            sum += rand
        }
        var remaining = count
        let queue = DispatchQueue(label: "Test", qos: .background, attributes: [], autoreleaseFrequency: .workItem, target: nil)
        rands.forEach { (r) in
            DispatchQueue.global(qos: .background).async {
                value.access { (v) -> () in
                    v = v + r
                }
                queue.async {
                    remaining = remaining - 1
                }
            }
        }
        while remaining > 0 {
            Thread.sleep(forTimeInterval: 0.1)
        }

        let vSum = value.get()
        XCTAssert((sum == vSum) == expectMatch)
    }
    
    func testAsync() {
        asyncAccessTest(count: 200000, accessStrategy: SynchronizedValueAccessStrategy(), expectMatch: true)
        
    }
 
    func testAsyncFail() {
        asyncAccessTest(count: 200000, accessStrategy: BaseValueAccessStrategy(), expectMatch: false)
    }

}

