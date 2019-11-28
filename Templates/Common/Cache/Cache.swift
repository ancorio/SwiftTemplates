//
//  Cache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//


protocol Cache {
    associatedtype KeyType
    associatedtype ObjectType
    func getObject(_ key: KeyType) -> ObjectType?
}
