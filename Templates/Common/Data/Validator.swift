//
//  Validator.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol Validator {
    associatedtype ObjectType
    associatedtype ErrorType: Error
    
    func validate(_: ObjectType) throws
    
}

extension Validator {
    func fail(error: ErrorType) throws {
        throw error
    }
}
