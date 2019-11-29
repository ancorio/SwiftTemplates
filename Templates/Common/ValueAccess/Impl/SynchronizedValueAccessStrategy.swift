//
//  SynchronizedValueAccessStrategy.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class SynchronizedValueAccessStrategy: ValueAccessStrategy {

    let lock = NSLock()
    
    func access<ObjectType, ReturnType>(_ object: inout ObjectType, block: (inout ObjectType) -> (ReturnType)) -> ReturnType {
        lock.lock()
        let result = block(&object)
        lock.unlock()
        return result
    }
}
