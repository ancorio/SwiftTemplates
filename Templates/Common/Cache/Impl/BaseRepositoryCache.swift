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
    
    func removeObject(_ key: RepositoryType.KeyType) {
        cache.access { (dict) in
            dict.removeValue(forKey: key)
        }
    }
    
    func removeObjects<C>(_ keys: C) where C : Collection, RepositoryType.KeyType == C.Element {
        cache.access { (dict) in
            keys.forEach { (key) in
                dict.removeValue(forKey: key)
            }
        }
    }
    
    func removeAllObjects() {
        cache.access { (dict) in
            dict.removeAll()
        }
    }
    
    func containsObject(_ key: RepositoryType.KeyType) -> Bool {
        return cache.access { (dict) -> Bool in
            return dict.keys.contains(key)
        }
    }
    
    func preloadObjects<C>(_ keys: C) where C : Collection, RepositoryType.KeyType == C.Element {
        cache.access { (dict) in
            let existingKeys = dict.keys
            let uncachedKeys = keys.filter({ (key) -> Bool in
                return !existingKeys.contains(key)
            })
            if uncachedKeys.count > 0 {
                repository.loadObjects(uncachedKeys).enumerated().forEach { (offset, element) in
                    dict[element.key] = element.value
                }
            }
        }
    }
    
    
    func getObject(_ key: RepositoryType.KeyType) -> RepositoryType.ObjectType? {
        return cache.access { (dict) -> RepositoryType.ObjectType? in
            if let obj = dict[key] {
                return obj
            } else {
                if let obj = repository.loadObjects([key])[key] {
                    dict[key] = obj
                    return obj
                }
            }
            return nil
        }
    }
    
}
