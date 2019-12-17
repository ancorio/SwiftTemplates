//
//  ModelCreatorFactory.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct ModelCreatorFactory {

    static func makeUserCreator() -> UserModelCreator {
        return UserModelCreator()
    }
    
    static func makeJsonApiResponseCreator() -> Creator<JsonApiResponse> {
        return JsonApiResponseCreator()
    }
    
    static func makeArrayCreator<ObjectType>() -> Creator<[ObjectType]> {
        return ArrayCreator<ObjectType>()
    }
    
}


