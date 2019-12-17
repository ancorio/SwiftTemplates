//
//  NetworkResponse.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

public protocol HttpHeaders {
    var allHeaderFields: [AnyHashable : Any] { get }
}

struct BaseHttpHeaders: HttpHeaders {
    var allHeaderFields: [AnyHashable : Any]
}

public protocol NetworkResponseHead: HttpHeaders {
    var statusCode: Int { get }
}


public protocol NetworkResponseData {
    
    func responseData() -> Data?
    func responseDataStream() -> InputStream?
    
}

public typealias NetworkResponse = NetworkResponseHead & NetworkResponseData


extension HTTPURLResponse: NetworkResponseHead {
    
}

extension Data: NetworkResponseData {
    
    public func responseData() -> Data? {
        return self
    }
    
    public func responseDataStream() -> InputStream? {
        return InputStream(data: self)
    }

}

extension URL: NetworkResponseData {
    
    public func responseData() -> Data? {
        return try? Data(contentsOf: self)
    }
    
    public func responseDataStream() -> InputStream? {
        return InputStream(url: self)
    }

}
