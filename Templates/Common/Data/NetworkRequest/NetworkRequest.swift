//
//  NetworkRequest.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public protocol URLScheme {
    func asString() -> String
}

public enum BaseURLScheme: URLScheme {
    case http
    case https
    case custom(String)
    
    public func asString() -> String {
        switch self {
        case .http:
            return "http"
        case .https:
            return "https"
        case .custom(let value):
            return value
        }
    }
    
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case options = "OPTIONS"
    case delete = "DELETE"
    case head = "HEAD"
    case connect = "CONNECT"
    case trace = "TRACE"
}


public protocol NetworkRequestBody {
    func httpBodyStream() -> (InputStream?, Int)
}

public struct EmptyNetworkRequestBody: NetworkRequestBody {
    public func httpBodyStream() -> (InputStream?, Int) {
        return (nil, 0)
    }
}

public struct URLEncodedRequestBody: NetworkRequestBody, URLParameters {
    var parametersBuilder: URLParametersBuilder
    public var parameters: [String : String]
    
    public func httpBodyStream() -> (InputStream?, Int) {
        return parametersBuilder.buildStream(self)
    }
}

public struct DataNetworkRequestBody: NetworkRequestBody {
    var data: Data
    
    public func httpBodyStream() -> (InputStream?, Int) {
        return (InputStream(data: data), data.count)
    }
}

public struct MultipartNetworkRequestBody: NetworkRequestBody {
    
    public func httpBodyStream() -> (InputStream?, Int) {
#warning("TODO")
        fatalError("TOOD")
    }
}

public protocol NetworkRequest {
    var httpMethod: HttpMethod { get set }
    var headers: HttpHeaders { get set }
    var urlBuilder: URLBuilder { get set }
    var body: NetworkRequestBody? { get set }
}


struct BaseNetworkRequest: NetworkRequest {
    var httpMethod: HttpMethod
    var headers: HttpHeaders
    var urlBuilder: URLBuilder
    var body: NetworkRequestBody?
}
