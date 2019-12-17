//
//  JsonEntityTest.swift
//  TemplatesTests
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import XCTest
@testable import Templates

class JsonEntityTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func parse(json: String) -> JsonEntity {
        do {
          return try JSONSerialization.jsonEntity(string: json)
        } catch {
            XCTAssert(false, "Cannot parse: " + json)
            fatalError()
        }
    }
    
    let jsonStrings = ["{}", "[]", "[\"X\"]", "[\"X\", 5, false, null, 5.445, 2342323632333]", "{\"x\": {\"y\": null}}"]
    let jsonNotStrings = ["t{}", "[\"ssddsds]", "[\"X\"]dgds", "[\"X\", 5: {, false, null, 5.445, 2342323632333]", "{\"x\": {\"y\": }"]
    
    func testParseString() {
        jsonStrings.forEach { (json) in
            XCTAssertNotNil(try? JSONSerialization.jsonEntity(string: json))
        }
        jsonNotStrings.forEach { (json) in
            XCTAssertNil(try? JSONSerialization.jsonEntity(string: json))
        }
        
    }
    
    func testParseData() {
        jsonStrings.forEach { (json) in
            XCTAssertNotNil(try? JSONSerialization.jsonEntity(data: json.data(using: .utf8)))
        }
        jsonNotStrings.forEach { (json) in
            XCTAssertNil(try? JSONSerialization.jsonEntity(data: json.data(using: .utf8)))
        }
    }
    
    func parseTestCheck(json: JsonEntity?) {
        XCTAssertNotNil(json)
        guard let json = json else {
            return
        }
        XCTAssertTrue(json.isDictionary())
        let dict = json.dictionary()
        if let v = dict["float_s"] {
            XCTAssertTrue(v.isString())
            XCTAssertFalse(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "2.5")
            XCTAssertEqual(v.float(), Float(2.5))
            XCTAssertEqual(v.double(), Double(2.5))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["float_n"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "2.5")
            XCTAssertEqual(v.float(), Float(2.5))
            XCTAssertEqual(v.double(), Double(2.5))
            XCTAssertEqual(v.int32(), Int32(2))
            XCTAssertEqual(v.int64(), Int64(2))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["int_s"] {
            XCTAssertTrue(v.isString())
            XCTAssertFalse(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "7")
            XCTAssertEqual(v.float(), Float(7))
            XCTAssertEqual(v.double(), Double(7))
            XCTAssertEqual(v.int32(), Int32(7))
            XCTAssertEqual(v.int64(), Int64(7))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["int_n"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "7")
            XCTAssertEqual(v.float(), Float(7))
            XCTAssertEqual(v.double(), Double(7))
            XCTAssertEqual(v.int32(), Int32(7))
            XCTAssertEqual(v.int64(), Int64(7))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["string"] {
            XCTAssertTrue(v.isString())
            XCTAssertFalse(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "Hello")
            XCTAssertEqual(v.float(), Float(0))
            XCTAssertEqual(v.double(), Double(0))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["null"] {
            XCTAssertFalse(v.isString())
            XCTAssertFalse(v.isNumber())
            XCTAssertTrue(v.isNull())
            XCTAssertEqual(v.string(), "")
            XCTAssertEqual(v.float(), Float(0))
            XCTAssertEqual(v.double(), Double(0))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(false))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["bool_s_f"] {
            XCTAssertTrue(v.isString())
            XCTAssertFalse(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "false")
            XCTAssertEqual(v.float(), Float(0))
            XCTAssertEqual(v.double(), Double(0))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(false))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["bool_s_t"] {
            XCTAssertTrue(v.isString())
            XCTAssertFalse(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "true")
            XCTAssertEqual(v.float(), Float(0))
            XCTAssertEqual(v.double(), Double(0))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["bool_s_f1"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "0")
            XCTAssertEqual(v.float(), Float(0))
            XCTAssertEqual(v.double(), Double(0))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(false))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["bool_s_t1"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "1")
            XCTAssertEqual(v.float(), Float(1.0))
            XCTAssertEqual(v.double(), Double(1.0))
            XCTAssertEqual(v.int32(), Int32(1))
            XCTAssertEqual(v.int64(), Int64(1))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["bool_i_f"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "0")
            XCTAssertEqual(v.float(), Float(0))
            XCTAssertEqual(v.double(), Double(0))
            XCTAssertEqual(v.int32(), Int32(0))
            XCTAssertEqual(v.int64(), Int64(0))
            XCTAssertEqual(v.bool(), Bool(false))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        if let v = dict["bool_i_t"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "1")
            XCTAssertEqual(v.float(), Float(1))
            XCTAssertEqual(v.double(), Double(1))
            XCTAssertEqual(v.int32(), Int32(1))
            XCTAssertEqual(v.int64(), Int64(1))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
        if let v = dict["bool_i_t2"] {
            XCTAssertFalse(v.isString())
            XCTAssertTrue(v.isNumber())
            XCTAssertFalse(v.isNull())
            XCTAssertEqual(v.string(), "100")
            XCTAssertEqual(v.float(), Float(100))
            XCTAssertEqual(v.double(), Double(100))
            XCTAssertEqual(v.int32(), Int32(100))
            XCTAssertEqual(v.int64(), Int64(100))
            XCTAssertEqual(v.bool(), Bool(true))
            XCTAssertEqual(v.array().count, 0)
            XCTAssertEqual(v.dictionary().count, 0)
        } else {
            XCTAssert(false)
        }
        
    }
    
    static let baseJson =
    " \"float_s\": \"2.5\", " +
    " \"float_n\": 2.5, " +
        
    " \"int_s\": \"7\", " +
    " \"int_n\": 7, " +
    
    " \"string\": \"Hello\", " +
    " \"null\": null, " +
    " \"bool_s_f\": \"false\", " +
    " \"bool_s_t\": \"true\", " +
    " \"bool_s_f1\": false, " +
    " \"bool_s_t1\": true, " +
    " \"bool_i_f\": 0, " +
    " \"bool_i_t\": 1, " +
    " \"bool_i_t2\": 100"
        
    
    let bigJson = "{" + baseJson + ", \"repeat\": {" + baseJson + "}, \"array\": [{" + baseJson  + "}, {" + baseJson  + "}, {" + baseJson  + "}]}"
    
    func testParseTypes() {
        let json = try? JSONSerialization.jsonEntity(string: bigJson)
        XCTAssertNotNil(json)
        parseTestCheck(json: json)
        let rep = json!.dictionary()["repeat"]
        parseTestCheck(json: rep)
        let arr = json!.dictionary()["array"]
        XCTAssertNotNil(arr)
        XCTAssertTrue(arr!.isArray())
        XCTAssertEqual(arr!.array().count, 3)
        arr!.array().forEach { (dict) in
            parseTestCheck(json: dict)
        }
        
    }
    func testSubscriptsTypes() {
        let json = try? JSONSerialization.jsonEntity(string: bigJson)
        XCTAssertNotNil(json)
        parseTestCheck(json: json)
        let rep = json!["repeat"]
        parseTestCheck(json: rep)
        let arr = json!["array"]
        XCTAssertNotNil(arr)
        XCTAssertTrue(arr!.isArray())
        XCTAssertEqual(arr!.array().count, 3)
        parseTestCheck(json: arr![0])
        parseTestCheck(json: arr![1])
        parseTestCheck(json: arr![2])
        let s = ["1", "2"]
        let z: JsonEntity = s as JsonEntity
        XCTAssertEqual(s[0], "1")
        XCTAssertEqual(s[1], "2")
        XCTAssertEqual(z[0].string(), "1")
        XCTAssertEqual(z[1].string(), "2")
        print(s[0], z[0])
        // Testing subscripts as well
        
    }
    

    func testParseTest() {
      //  XCTAssert(parse(json: "{}").type().isNull)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


}
