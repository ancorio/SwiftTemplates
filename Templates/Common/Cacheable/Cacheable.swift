//
//  Cacheable.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

/*
 Things i dont like:
 We can eleminate 'protocol Cacheable' completely, as currently Repository completely defines key and value type of cacheable object
 Implementation of Cacheable limits each class cache possibility to single field, so it will require CacheableWrapper to implement several caheable field for single class. If we eleminate 'protocol Cacheable' this problem disappears then Repository determines which field to use for data requests. Then Repositories will look like:
 
 UserByIdRepository
 UserByEmailRepository
 
 */
protocol Cacheable {
    associatedtype KeyType
    func cacheableKey() -> KeyType?
}
