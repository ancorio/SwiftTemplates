//
//  UserModel.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

class UserModel {
    var id: UUID?
    var email: String?
    
}

extension UserModel: Cacheable {
    
    func cacheableKey() -> UUID? {
        return id
    }
    
}

extension UserModel: CustomStringConvertible {
    var description: String {
        return "User \(String(describing: id)) \(String(describing: email))"
    }
}
