//
//  UserNetworkService.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit



class UserNetworkService {

    static let instance = UserNetworkService()
    
    let usersFetcher = NetworkFetcherStub(filename: "get_users")
    
}
