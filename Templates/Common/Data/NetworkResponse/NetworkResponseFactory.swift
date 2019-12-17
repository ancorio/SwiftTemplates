//
//  NetworkResponseFactory.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public struct NetworkResponseFactory {
    
    public static func makeNetworkResponse(head: NetworkResponseHead, data: NetworkResponseData?) -> NetworkResponse {
        return BaseNetworkResponse(head: head, data: data)
    }
    
    public static func makeNetworkResponse(httpResponse: HTTPURLResponse, data: Data?) -> NetworkResponse {
        return makeNetworkResponse(head: httpResponse, data: data)
    }
    
    public static func makeNetworkResponse(httpResponse: HTTPURLResponse, url: URL?) -> NetworkResponse {
        return makeNetworkResponse(head: httpResponse, data: url)
    }
    
}
