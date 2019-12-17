//
//  Serializer.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public protocol Serializer {
    associatedtype FromType
    associatedtype ToType
    associatedtype ErrorType: Error
    
    func serialize(_: FromType) throws -> ToType
    
}

public extension Serializer {
    func fail(error: ErrorType) throws {
        throw error
    }
}

public protocol NetworkResponseSerializer: Serializer where FromType == NetworkResponse {
    
}

public protocol ToJsonSerializer: Serializer where ToType == JsonEntity, ErrorType == ToJsonSerializationError {
    
}

public typealias NetworkResponseToJsonResponse = NetworkResponseSerializer & ToJsonSerializer
