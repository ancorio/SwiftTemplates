//
//  Cacheable.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

protocol Cacheable {
    associatedtype KeyType
    func cacheableKey() -> KeyType?
}
