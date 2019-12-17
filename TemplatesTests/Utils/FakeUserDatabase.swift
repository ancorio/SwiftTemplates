//
//  FakeUserDatabase.swift
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


class FakeUserDatabase {
    
    static let user1Id = UUID()
    static let user2Id = UUID()
    static let user3Id = UUID()
    static let user4Id = UUID()
    static let user5Id = UUID()
    static let user1Email = "user1@mail.com"
    static let user2Email = "user2@mail.com"
    static let user3Email = "user3@mail.com"
    static let user4Email = "user4@mail.com"
    static let user5Email = "user5@mail.com"
    
    
    
    private var debugUsers = [
        UserDBModel(id: user1Id, email: user1Email),
        UserDBModel(id: user2Id, email: user2Email),
        UserDBModel(id: user3Id, email: user3Email),
        UserDBModel(id: user4Id, email: user4Email),
        UserDBModel(id: user5Id, email: user5Email)
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
