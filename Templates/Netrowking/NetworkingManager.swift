//
//  NetworkingManager.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public typealias NetworkResponseBlock = (NetworkResponse)->()
public typealias NetworkSessionIdentifier = String

public class NetworkingManager {
    
    private var urlSessions = [NetworkSessionIdentifier : URLSession]()
    private var requestBuilder = URLRequestBuilderFactory.makeURLRequestBuilder()
    
    public func register(id: NetworkSessionIdentifier, urlSession: URLSession) {
        urlSessions[id] = urlSession
    }
    
    public func request<T: NetworkingManagerTask>(_ request: NetworkRequest, session sid: NetworkSessionIdentifier, task: T, response: @escaping NetworkResponseBlock) -> T.TaskType {
        guard let session = urlSessions[sid] else {
            fatalError("Unknown NetworkSessionIdentifier")
        }
        let urlRequest = requestBuilder.build(request)
        return task.makeTask(session: session, request: urlRequest)
    }
    
}
