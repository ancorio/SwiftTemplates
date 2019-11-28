//
//  CacheableRepository.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

protocol CacheableRepository {
    associatedtype KeyType: Hashable
    associatedtype ObjectType: Cacheable
    func loadObjects(_ keys: Set<KeyType>) -> [KeyType : ObjectType]
}
