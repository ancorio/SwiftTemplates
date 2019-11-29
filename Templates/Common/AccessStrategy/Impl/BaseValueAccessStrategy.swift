//
//  BaseValueAccessStrategy.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class BaseValueAccessStrategy: ValueAccessStrategy {

    func access<ObjectType, ReturnType>(_ object: inout ObjectType, block: (inout ObjectType) -> (ReturnType)) -> ReturnType {
        return block(&object)
    }

}
