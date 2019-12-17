//
//  BaseURLRequestBuilder.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct BaseURLRequestBuilder: URLRequestBuilder {
    
    func build(_ networkRequest: NetworkRequest) -> URLRequest {
        var request = URLRequest(url: networkRequest.urlBuilder.url())
        request.httpMethod = networkRequest.httpMethod.rawValue
        networkRequest.headers.allHeaderFields.forEach { (key, value) in
            // Type cast, can be refactored?
            if let key = key as? String, let value = value as? String {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let body = networkRequest.body {
            let streamInfo = body.httpBodyStream()
            request.httpBodyStream = streamInfo.0
            request.addValue(String(streamInfo.1), forHTTPHeaderField: "Content-Length")
        }
        
        return request
    }
    

}
