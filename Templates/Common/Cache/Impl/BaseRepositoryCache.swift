//
//  BaseRepositoryCache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

// Thing i don't like - BaseRepositoryCache's key and value types are defined by repository, not by BaseRepositoryCache itself

class BaseRepositoryCache<RepositoryType: CacheableRepository> {
    
    let repository: RepositoryType
    
    #warning("TODO")

    var cache = BaseSafeDictionary<RepositoryType.KeyType, RepositoryType.ObjectType>()
    
    init(repository: RepositoryType) {
        self.repository = repository
    }

}


extension BaseRepositoryCache: RepositoryCache {
    
    func getObject(_ key: RepositoryType.KeyType) -> RepositoryType.ObjectType? {
        return cache.access { (dict) -> RepositoryType.ObjectType? in
            if let obj = dict[key] {
                return obj
            } else {
                if let obj = repository.loadObjects(Set([key]))[key] {
                    dict[key] = obj
                    return obj
                }
            }
            return nil
        }
    }
    
    func preloadObjects(_ keys: Set<RepositoryType.KeyType>) { //PreloadStrategy?
        cache.access { (dict) in
            repository.loadObjects(keys).enumerated().forEach { (offset, element) in
                dict[element.key] = element.value
            }
        }
        
    }
    
}
