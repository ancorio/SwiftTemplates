//
//  UserModel.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

struct UserModel {
    var id: UUID?
    var email: String?
    
}

extension UserModel: Equatable {
    
    public static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension UserModel: CustomStringConvertible {
    var description: String {
        return "User \(String(describing: id)) \(String(describing: email))"
    }
}
