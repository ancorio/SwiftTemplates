//
//  UserDatabase.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

class DBModel {
    
}

class UserDBModel: DBModel {
    
    typealias IdType = UUID
    typealias EmailType = String
    
    var id: IdType?
    var email: EmailType?
    
    fileprivate init(id: UUID?, email: EmailType?) {
        self.id = id
        self.email = email
    }
}


class UserDatabase {
    
    static let user1Id = UUID()
    static let user2Id = UUID()
    static let user3Id = UUID()
    static let user4Id = UUID()
    static let user5Id = UUID()
    
    private var debugUsers = [
        UserDBModel(id: UserDatabase.user1Id, email: "user1@mail.com"),
        UserDBModel(id: UserDatabase.user2Id, email: "user2@mail.com"),
        UserDBModel(id: UserDatabase.user3Id, email: "user3@mail.com"),
        UserDBModel(id: UserDatabase.user4Id, email: "user4@mail.com"),
        UserDBModel(id: UserDatabase.user5Id, email: "user5@mail.com")
    ]
    
    func getUsers<C: Collection>(ids: C) -> [UserDBModel] where C.Element == UserDBModel.IdType {
        return debugUsers.filter { (user) -> Bool in
            if let id = user.id {
                return ids.contains(id)
            } else {
                return false
            }
        }
    }
    
    func getUsers<C: Collection>(emails: C) -> [UserDBModel] where C.Element == UserDBModel.EmailType {
        return debugUsers.filter { (user) -> Bool in
            if let email = user.email {
                return emails.contains(email)
            } else {
                return false
            }
        }
    }

}
