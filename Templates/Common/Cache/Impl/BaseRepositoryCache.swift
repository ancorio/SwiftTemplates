//
//  BaseRepositoryCache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

class BaseRepositoryCache<RepositoryType: CacheableRepository> {
    
    var repository: RepositoryType
    
    var cache = [AnyHashable: RepositoryType.ObjectType]()
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
}


extension BaseRepositoryCache: Cache {
    
    func getObject(_ key: RepositoryType.KeyType) -> RepositoryType.ObjectType? {
        if let obj = cache[key] {
            return obj
        } else {
            if let obj = repository.loadObjects(Set([key]))[key] {
                cache[key] = obj
                return obj
            }
        }
        return nil
    }
}
