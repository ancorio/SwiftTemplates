//
//  UserRepository.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

class UserRepository: CacheableRepository {
    
    func debug(map dbUser: UserDBModel, into model: UserModel) {
        model.id = dbUser.id
        model.email = dbUser.email
    }
    
    func loadObjects(_ keys: Set<UUID>) -> [UUID : UserModel] {
        return UserDatabase().getUsers(ids: keys).reduce(into: [UUID : UserModel]()) { (result, dbUser) in
            let model = UserModel()
            debug(map: dbUser, into: model)
            if let id = model.id { // accessing model property
                result[id] = model
            }
        }
    }
}
