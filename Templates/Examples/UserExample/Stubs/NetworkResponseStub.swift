//
//  NetworkResponseStub.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class NetworkResponseStub: NetworkResponse {

    private let data: Data
    
    init(filename: String) {
        data = try! Data(contentsOf: Bundle.main.url(forResource: filename, withExtension: "json")!)
    }
    
    var statusCode: Int {
        get {
            return 200
        }
    }
    
    func responseData() -> Data? {
        return data
    }
    
    func responseDataStream() -> InputStream? {
        return data.responseDataStream()
    }
    
    var allHeaderFields: [AnyHashable : Any] {
        get {
            return [:]
        }
    }
    

}
