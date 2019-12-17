//
//  Mapper.swift
//  Templates
//
//  Created by user on 12/10/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

typealias MapperResult = Result

protocol Mapper {
    associatedtype FromType
    associatedtype ToType
    associatedtype MapperErrorType: Error
    
    func map(_ : FromType) -> MapperResult<ToType, MapperErrorType>

}
