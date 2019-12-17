//
//  User.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol UserModel {
    var id: UUID! { get set }
    var name: String! { get set }
    var email: String! { get set }
    
}

struct BaseUserModel: UserModel {
    var id: UUID!
    var name: String!
    var email: String!
}

class UserModelCreator: Creator<UserModel> {
    
    override func create() -> UserModel {
        return BaseUserModel()
    }
}

