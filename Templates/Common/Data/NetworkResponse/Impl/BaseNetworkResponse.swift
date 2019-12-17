//
//  BaseNetworkResponse.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public struct BaseNetworkResponse {
    public let head: NetworkResponseHead
    public let data: NetworkResponseData?
}

extension BaseNetworkResponse: NetworkResponse {
    public var statusCode: Int {
        return head.statusCode
    }
    
    public var allHeaderFields: [AnyHashable : Any] {
        return head.allHeaderFields
    }
    
    public func responseData() -> Data? {
        return data?.responseData()
    }
    
    public func responseDataStream() -> InputStream? {
        return data?.responseDataStream()
    }
    
    
}
