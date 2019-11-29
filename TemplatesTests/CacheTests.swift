//
//  TemplatesTests.swift
//  TemplatesTests
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import XCTest
@testable import Templates


fileprivate struct UserModel: Equatable {
    var id: UUID?
    var email: String?
    
    mutating func from(dbUser user: UserDBModel) {
        id = user.id
        email = user.email
    }
    
}

fileprivate class UserByIdRepository: Repository {
    
    var loadRequestsCount = 0
    var loadResultsCount = 0
    
    func loadObjects<C>(_ keys: C) -> [UUID : UserModel] where C : Collection, UUID == C.Element {
        self.loadRequestsCount += keys.count
        return UserDatabase().getUsers(ids: keys).reduce(into: [UUID : UserModel]()) { (result, dbUser) in
            self.loadResultsCount = self.loadResultsCount + 1
            var model = UserModel()
            model.from(dbUser: dbUser)
            if let id = model.id {
                result[id] = model
            }
        }
    }
    
}
/*
var repo = BaseRepositoryCache(repository: UserByIdRepository())
print(repo.getObject(UserDatabase.user1Id))
print(repo.getObject(UserDatabase.user2Id))
print(repo.getObject(UserDatabase.user1Id) == repo.getObject(UserDatabase.user1Id))
print(repo.getObject(UserDatabase.user1Id) == repo.getObject(UserDatabase.user2Id))
print(repo.getObject(UUID()))
 */

class CacheTests: XCTestCase {

    fileprivate var cache: BaseRepositoryCache<UserByIdRepository>?
    let ids = [UserDatabase.user1Id, UserDatabase.user2Id, UserDatabase.user3Id, UserDatabase.user4Id, UserDatabase.user5Id]
    let emails = [UserDatabase.user1Email, UserDatabase.user2Email, UserDatabase.user3Email, UserDatabase.user4Email, UserDatabase.user5Email]
    
    override func setUp() {
        cache = BaseRepositoryCache(repository: UserByIdRepository())
    }

    override func tearDown() {
        cache = nil
    }

    func testUnexistingUser() {
        let unexistingRequestsCount = 10
        for _ in 0..<unexistingRequestsCount {
            XCTAssert(cache!.getObject(UUID()) == nil)
        }
        
        ids.forEach { (uuid) in
            XCTAssert(cache!.getObject(UUID()) != cache!.getObject(uuid))
        }
        XCTAssert(cache!.repository.loadRequestsCount == unexistingRequestsCount + ids.count * 2)
        XCTAssert(cache!.repository.loadResultsCount == ids.count)
        
        
    }
    
    func testProperUserCached() {
        zip(ids, emails).forEach { (id, email) in
            let testUser = UserModel(id: id, email: email)
            let cachedUser = cache!.getObject(testUser.id!)!
            XCTAssert(cachedUser == testUser)
        }
        XCTAssert(cache!.repository.loadRequestsCount == ids.count)
        XCTAssert(cache!.repository.loadResultsCount == ids.count)
    }
    
    func testProperUserCachedRepeat() {
        let repeats = 10
        for _ in 0..<repeats {
            testProperUserCached()
        }
    }
    
    func testEquality() {
        
        ids.forEach { (uuid1) in
            ids.forEach { (uuid2) in
                let equal = uuid1 == uuid2
                let usersEqual = cache!.getObject(uuid1) == cache!.getObject(uuid2)
                XCTAssert(equal == usersEqual)
            }
        }
        XCTAssert(cache!.repository.loadRequestsCount == ids.count)
        XCTAssert(cache!.repository.loadResultsCount == ids.count)
        
    }
/*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}
