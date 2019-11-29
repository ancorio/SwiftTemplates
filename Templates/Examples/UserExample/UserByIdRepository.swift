//
//  UserByIdRepository.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

class UserByIdRepository: Repository {
    
    func loadObjects<C>(_ keys: C) -> [UUID : UserModel] where C : Collection, UUID == C.Element {
        return UserDatabase().getUsers(ids: keys).reduce(into: [UUID : UserModel]()) { (result, dbUser) in
            var model = UserModel()
            debug(map: dbUser, into: &model)
            if let id = model.id { // accessing model property
                result[id] = model
            }
        }
    }
    
    func debug(map dbUser: UserDBModel, into model: inout UserModel) {
        model.id = dbUser.id
        model.email = dbUser.email
    }
}
