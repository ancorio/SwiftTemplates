//
//  Repository.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

protocol Repository {
    associatedtype KeyType: Hashable
    associatedtype ObjectType
    func loadObjects(_ keys: Set<KeyType>) -> [KeyType : ObjectType]
}
