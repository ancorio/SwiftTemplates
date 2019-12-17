//
//  AccessedValue.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/29/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct AccessedValue<T> {

    private var value: T
    var accessStrategy: ValueAccessStrategy
    
    init(value: T, accessStrategy: ValueAccessStrategy = BaseValueAccessStrategy()) {
        self.value = value
        self.accessStrategy = accessStrategy
    }
    
    @discardableResult
    mutating func access<ReturnType>(_ block: (inout T) -> (ReturnType)) -> ReturnType {
        return accessStrategy.access(&value, block: block)
    }
    
    func get() -> T {
        return value
    }
    
}

