//
//  BaseSafeDictionary.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class BaseSafeDictionary<KeyType: Hashable, ValueType> {
    
    var underlying = [KeyType: ValueType]()
    
    fileprivate func privateAccess<T>(block: (inout [KeyType : ValueType]) -> (T)) -> T {
        return block(&underlying)
    }
}

extension BaseSafeDictionary: SafeDictionary {
    
    func access<T>(block: (inout [KeyType : ValueType]) -> (T)) -> T {
        return privateAccess(block: block)
    }

}


class BaseSynchronizedSafeDictionary<KeyType: Hashable, ValueType>: BaseSafeDictionary<KeyType, ValueType> {
    
    let lock = NSLock()
    
    override func privateAccess<T>(block: (inout [KeyType : ValueType]) -> (T)) -> T {
#warning("implement proper synchronizarion")
        lock.lock()
        let result = super.privateAccess(block: block)
        lock.unlock()
        return result
    }
}
