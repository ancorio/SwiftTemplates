//
//  PreloadableCache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

#warning("How to use generic Collection or Sequence as keys type?")

protocol PreloadableCache: Cache {
    func preloadObjects(_ keys: Set<KeyType>)
}
