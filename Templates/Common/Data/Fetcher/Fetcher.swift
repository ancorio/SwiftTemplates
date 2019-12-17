//
//  Fetcher.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation


protocol Fetcher {
    
    associatedtype RequestType
    associatedtype ResultType
    associatedtype ErrorType: Error
    
    func fetch(request: RequestType, result: @escaping (FetcherResult<ResultType, ErrorType>)->())
    
}

