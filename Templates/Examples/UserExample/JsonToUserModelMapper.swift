//
//  JsonToUserModelMapper.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol JsonToUserModelMapper: Mapper where FromType == JsonEntity, ToType == UserModel, MapperErrorType == JsonApiResponseMapperError {
}

class BaseJsonToUserModelMapper: BaseMapper<JsonEntity, UserModel, JsonApiResponseMapperError> {
    
    let creator: Creator<UserModel>
    
    init(creator: Creator<UserModel>) {
        self.creator = creator
    }
    
    override func map(_ from: JsonEntity) -> Result<UserModel, JsonApiResponseMapperError> {
        if from.isDictionary() {
            let keys = Set<String>(["id", "email", "name"])
            for key in from.missingKeys(keys) {
                return .error(.fieldIsMissing(key))
            }
            var result = creator.create()
            result.id = from["id"]?.uuid()
            result.name = from["name"]?.string()
            result.email = from["email"]?.string()
            return .success(result)
        } else {
            return .error(.invalidFieldType("User root object"))
        }
        
    }
    
}
