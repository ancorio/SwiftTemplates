//
//  PurgeableCache.swift
//  Templates
//
//  Created by user on 12/9/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol PurgeableCache: Cache {
    func removeObject(_ key: KeyType)
    func removeObjects<C: Collection>(_ keys: C ) where C.Element == KeyType
    func removeAllObjects()
}
