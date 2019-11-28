//
//  SafeDictionary.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol SafeDictionary {
    associatedtype KeyType: Hashable
    associatedtype ValueType
    
    func access(block: ( inout [KeyType:ValueType])->())
    
}
