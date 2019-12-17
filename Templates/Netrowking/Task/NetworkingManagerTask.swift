//
//  NetworkingManagerTask.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

#warning("Needs refactor for upload possibility")

public protocol NetworkingManagerTask {
    associatedtype TaskType: URLSessionTask
    func makeTask(session: URLSession, request: URLRequest) -> TaskType
}

protocol DataNetworkingManagerTask: NetworkingManagerTask where TaskType == URLSessionDataTask {}

fileprivate struct BaseDataNetworkingManagerTask: DataNetworkingManagerTask {
    func makeTask(session: URLSession, request: URLRequest) -> URLSessionDataTask {
        return session.dataTask(with: request)
    }
}

protocol DownloadNetworkingManagerTask: NetworkingManagerTask where TaskType == URLSessionDownloadTask {}

fileprivate struct BaseDownloadNetworkingManagerTask: DownloadNetworkingManagerTask {
    func makeTask(session: URLSession, request: URLRequest) -> URLSessionDownloadTask {
        return session.downloadTask(with: request)
    }
}

struct NetworkingManagerTaskFactory {
    static func makeDataTask<T: DataNetworkingManagerTask>() -> T {
        return BaseDataNetworkingManagerTask() as! T
    }
    
    static func makeDownloadTask<T: DownloadNetworkingManagerTask>() -> T {
        return BaseDownloadNetworkingManagerTask() as! T
    }
    
}

/*
URLSessionStreamTask
URLSessionWebSocketTask
*/
