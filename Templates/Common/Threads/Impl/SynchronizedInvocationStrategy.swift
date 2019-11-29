//
//  SynchronizedInvocationStrategy.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/29/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct SynchronizedInvocationStrategy: InvocationStrategy {
    
    let lock = NSLock()
    
    func invoke(_ block: @escaping () -> ()) {
        lock.lock()
        block()
        lock.unlock()
    }
    
    

}
