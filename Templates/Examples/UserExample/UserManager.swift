//
//  UserManager.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class UserManager {
    
    let userService = UserNetworkService()
    
    func getUsers(block: @escaping (Result<[UserModel], Error>)->()) {
        userService.usersFetcher.wrap(mapper: MapperFactory.makeNetworkResponseToJsonMapper()).wrap(mapper: MapperFactory.makeJsonApiResponseMapper()).wrap(mapper: MapperFactory.makeGetUsersMapper()).fetch(request: NetworkRequestStub()) { (result) in
            switch result {
            case .success(let users):
                block(.success(users))
            case .error(let error):
                block(.error(error))
            }
        }
        
    }

}

