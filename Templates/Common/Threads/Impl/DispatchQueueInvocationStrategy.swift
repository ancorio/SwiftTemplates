//
//  DispatchQueueInvocationStrategy.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/29/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class DispatchQueueInvocationStrategy: InvocationStrategy {
    
    let queue: DispatchQueue
    let synchronized: Bool
    
    init(queue: DispatchQueue, synchronized: Bool = false) {
        self.queue = queue
        self.synchronized = synchronized
    }
    
    func invoke(_ block: @escaping () -> ()) {
        if synchronized {
            queue.sync(execute: block)
        } else {
            queue.async(execute: block)
        }
    }

}
