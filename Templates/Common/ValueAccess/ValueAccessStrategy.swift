//
//  ValueAccessStrategy.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol ValueAccessStrategy {
    
    func access<ObjectType, ReturnType>(_: inout ObjectType, block: (inout ObjectType) -> (ReturnType)) -> ReturnType
}
