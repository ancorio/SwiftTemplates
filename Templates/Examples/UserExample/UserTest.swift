//
//  UserTest.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import Foundation

class UserTest {
    
    func test() {
        var repo = BaseRepositoryCache(repository: UserRepository())
        print(repo.getObject(UserDatabase.user1Id))
        print(repo.getObject(UserDatabase.user2Id))
        print(repo.getObject(UserDatabase.user1Id) === repo.getObject(UserDatabase.user1Id))
        print(repo.getObject(UserDatabase.user1Id) === repo.getObject(UserDatabase.user2Id))
        print(repo.getObject(UUID()))
    }

}
