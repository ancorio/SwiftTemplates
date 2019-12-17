//
//  Cache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

protocol Cache {
    associatedtype KeyType: Hashable
    associatedtype ObjectType
    
    func containsObject(_ key: KeyType) -> Bool
    func getObject(_ key: KeyType) -> ObjectType?
}

