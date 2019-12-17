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
        return FakeUserDatabase().getUsers(ids: keys).reduce(into: [UUID : UserModel]()) { (result, dbUser) in
            self.loadResultsCount = self.loadResultsCount + 1
            var model = UserModel()
            model.from(dbUser: dbUser)
            if let id = model.id {
                result[id] = model
            }
        }
    }
    
}

class CacheTests: XCTestCase {

    fileprivate var cache: BaseRepositoryCache<UserByIdRepository>!
    let ids = [FakeUserDatabase.user1Id, FakeUserDatabase.user2Id, FakeUserDatabase.user3Id, FakeUserDatabase.user4Id, FakeUserDatabase.user5Id]
    let emails = [FakeUserDatabase.user1Email, FakeUserDatabase.user2Email, FakeUserDatabase.user3Email, FakeUserDatabase.user4Email, FakeUserDatabase.user5Email]
    
    override func setUp() {
        cache = BaseRepositoryCache(repository: UserByIdRepository())
    }

    override func tearDown() {
        cache = nil
    }

    func testUnexistingUser() {
        let unexistingRequestsCount = 10
        for _ in 0..<unexistingRequestsCount {
            XCTAssert(cache.getObject(UUID()) == nil)
        }
        
        ids.forEach { (uuid) in
            XCTAssert(cache.getObject(UUID()) != cache!.getObject(uuid))
        }
        XCTAssert(cache.repository.loadRequestsCount == unexistingRequestsCount + ids.count * 2)
        XCTAssert(cache.repository.loadResultsCount == ids.count)
        
        
    }
    
    func testProperUserCached() {
        zip(ids, emails).forEach { (id, email) in
            let testUser = UserModel(id: id, email: email)
            let cachedUser = cache!.getObject(testUser.id!)!
            XCTAssert(cachedUser == testUser)
        }
        XCTAssert(cache.repository.loadRequestsCount == ids.count)
        XCTAssert(cache.repository.loadResultsCount == ids.count)
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
        XCTAssert(cache.repository.loadRequestsCount == ids.count)
        XCTAssert(cache.repository.loadResultsCount == ids.count)
    }
    
    func testPreload() {
        XCTAssert(cache.repository.loadRequestsCount == 0)
        cache.preloadObjects(ids)
        XCTAssert(cache.repository.loadRequestsCount == ids.count)
        cache.preloadObjects(ids)
        XCTAssert(cache.repository.loadRequestsCount == ids.count)
        XCTAssert(cache.repository.loadResultsCount == ids.count)
        let fakeRequests = 5
        let fakeBatchSize = 5
        for i in 1...fakeRequests {
            var list = [UUID]()
            for _ in 0..<fakeBatchSize {
                list.append(UUID())
            }
            cache.preloadObjects(list)
            XCTAssert(cache.repository.loadRequestsCount == ids.count + i * fakeBatchSize)
        }
        XCTAssert(cache.repository.loadResultsCount == ids.count)
    }
    
    func testRemoveAll() {
        for i in 1...5 {
            for _ in 1...5 {
                cache.preloadObjects(ids)
                XCTAssert(cache.repository.loadRequestsCount == ids.count * i)
                XCTAssert(cache.repository.loadResultsCount == ids.count * i)
            }
            cache.removeAllObjects()
        }
    }
    
    func checkContains(index: Int) {
        ids.enumerated().forEach { (idx, id) in
            let shouldCountain = idx < index
            XCTAssert(shouldCountain == cache.containsObject(id))
        }
    }
    
    func testContains() {
        ids.enumerated().forEach { (idx, id) in
            checkContains(index: idx)
            _ = cache.getObject(id)
        }
        checkContains(index: ids.count)
        cache.removeAllObjects()
        checkContains(index: 0)
        cache.preloadObjects(ids)
        checkContains(index: ids.count)
        XCTAssert(cache.repository.loadRequestsCount == ids.count * 2)
        XCTAssert(cache.repository.loadResultsCount == ids.count * 2)
    }
    
    func testRemoveSingle() {
        ids.enumerated().forEach { (idx, id) in
            _ = cache.getObject(id)
            XCTAssert(cache.containsObject(id) == true)
            cache.removeObject(id)
            XCTAssert(cache.containsObject(id) == false)
            _ = cache.getObject(id)
            XCTAssert(cache.containsObject(id) == true)
        }
        XCTAssert(cache.repository.loadRequestsCount == ids.count * 2)
        XCTAssert(cache.repository.loadResultsCount == ids.count * 2)
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
