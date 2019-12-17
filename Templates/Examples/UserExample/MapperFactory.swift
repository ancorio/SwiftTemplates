//
//  MapperFactory.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct MapperFactory {

    static func makeJsonApiResponseMapper() -> JsonApiResponseMapper {
        return JsonApiResponseMapper(creator: ModelCreatorFactory.makeJsonApiResponseCreator())
    }
    
    static func makeNetworkResponseToJsonMapper() -> NetworkResponseToJsonMapper {
        return NetworkResponseToJsonMapper()
    }
    
    static func makeGetUsersMapper() -> JsonApiResponseArrayFieldMapper<UserModel> {
        return JsonApiResponseArrayFieldMapper(field: "users", objectMapper: BaseJsonToUserModelMapper(creator: ModelCreatorFactory.makeUserCreator()))
    }
    
    
    
}
