//
//  URLBuilderTests.swift
//  TemplatesTests
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import XCTest
@testable import Templates

class URLBuilderTests: XCTestCase {
    
    var builder: URLBuilder!

    override func setUp() {
        builder = URLBuilderFactory.makeURLBuilder()
    }
    
    let schemes: [URLScheme] = [BaseURLScheme.http, BaseURLScheme.https, BaseURLScheme.custom("ftp")]
    let domains = ["google.com", "example.com", "info.net", "net.info"]
    let paths = ["", "path", "path/123", "path/456/hello", "path/äöü"]
    
#warning("Cannot test with multiple params - order is not defined!")
    let params: [String: [String: String]] = [
        "param=param": ["param" : "param"],
        "param=%C3%A4%C3%B6%C3%BC": ["param" : "äöü"],
    ]
    
    
    func testScheme() {
        builder.domain = "example.com"
        builder.path = "path"
        
        schemes.forEach { (scheme) in
            builder.scheme = scheme
            XCTAssertEqual(builder.url(), URL(string: scheme.asString() + "://example.com/path")!)
            XCTAssertNotEqual(builder.url(), URL(string: scheme.asString() + "://example.com/path/")!)
        }
        builder.scheme = BaseURLScheme.http
    }
    
    func testDomain() {
        builder.scheme = BaseURLScheme.https
        builder.path = "path"
        
        domains.forEach { (domain) in
            builder.domain = domain
            XCTAssertEqual(builder.url(), URL(string: "https://" + domain + "/path")!)
            XCTAssertNotEqual(builder.url(), URL(string: "https://" + domain + "/path/")!)
        }
        builder.scheme = BaseURLScheme.http
    }
    
    func testPath() {
        builder.scheme = BaseURLScheme.https
        builder.domain = "example.com"
        
        paths.forEach { (path) in
            builder.path = path
            XCTAssertEqual(builder.url(), URL(string: "https://example.com/" + path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!)!)
            XCTAssertNotEqual(builder.url(), URL(string: "https://example.com/" + path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)! + "/")!)
        }
        builder.scheme = BaseURLScheme.http
    }
    
    func testParams() {
        builder.scheme = BaseURLScheme.https
        builder.domain = "example.com"
        builder.path = "path"
        params.forEach { (key, value) in
            builder.parameters = value
            XCTAssertEqual(builder.url(), URL(string: "https://example.com/path?" + key))
        }
        builder.scheme = BaseURLScheme.http
    }


}
