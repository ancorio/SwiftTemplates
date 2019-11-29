//
//  UnsafeInvocationStrategy.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/29/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct UnsafeInvocationStrategy: InvocationStrategy {
    
    func invoke(_ block: @escaping () -> ()) {
        block()
    }

}
