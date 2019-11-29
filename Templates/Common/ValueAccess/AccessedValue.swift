//
//  AccessedValue.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/29/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class AccessedValue<T> {

    var value: T
    var accessStrategy: ValueAccessStrategy
    
    init(value: T, accessStrategy: ValueAccessStrategy) {
        self.value = value
        self.accessStrategy = accessStrategy
    }
    
    func access<ReturnType>(_ block: (inout T) -> (ReturnType)) -> ReturnType {
        return accessStrategy.access(&value, block: block)
    }
    
}
