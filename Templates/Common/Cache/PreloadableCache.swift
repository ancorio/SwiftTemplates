//
//  PreloadableCache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//



protocol PreloadableCache: Cache {
    func preloadObjects<C: Collection>(_ keys: C ) where C.Element == KeyType
}
