//
//  BaseRepositoryCache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

// Thing i don't like - BaseRepositoryCache's key and value types are defined by repository, not by BaseRepositoryCache itself


class BaseRepositoryCache<RepositoryType: Repository> {
    
    let repository: RepositoryType

    private var cache: AccessedValue<[RepositoryType.KeyType: RepositoryType.ObjectType]>
    
    convenience init(repository: RepositoryType) {
        self.init(repository: repository, accessStrategy: BaseValueAccessStrategy())
    }
    
    init(repository: RepositoryType, accessStrategy: ValueAccessStrategy) {
        self.repository = repository
        self.cache = AccessedValue(value: [RepositoryType.KeyType: RepositoryType.ObjectType](), accessStrategy: accessStrategy)
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
