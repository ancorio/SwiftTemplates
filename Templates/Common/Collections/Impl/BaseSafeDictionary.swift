//
//  BaseSafeDictionary.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class BaseSafeDictionary<KeyType: Hashable, ValueType> {
    
    let cache: AccessedValue<[KeyType: ValueType]>
    
    init(accessStrategy: AccessStrategy = BaseAccessStrategy()) {
        cache = AccessedValue<[KeyType: ValueType]>(value: [KeyType: ValueType](), accessStrategy: accessStrategy)
    }
    
}
