//
//  NetworkFetcherStub.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct NetworkFetcherStub: NetworkFether {
    
    let filename: String
    
    func fetch(request: NetworkRequest, result: @escaping (FetcherResult<NetworkResponse, Error>) -> ()) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.2) {
            result(.success(NetworkResponseStub(filename: self.filename)))
        }
    }
    

}
