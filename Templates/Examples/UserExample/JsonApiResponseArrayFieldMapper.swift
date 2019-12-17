//
//  JsonApiResponseArrayFieldMapper.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

class BaseMapper<FT, TT, ET: Error>: Mapper {
    func map(_: FT) -> Result<TT, ET> {
        fatalError()
    }
    
    typealias FromType = FT
    
    typealias ToType = TT
    
    typealias MapperErrorType = ET
    
}

class JsonApiResponseArrayFieldMapper<ModelType>: BaseMapper<JsonApiResponse, [ModelType], JsonApiResponseMapperError> {
    
    let field: String
    let objectMapper: BaseMapper<JsonEntity, ModelType, JsonApiResponseMapperError>
    
    init(field: String, objectMapper: BaseMapper<JsonEntity, ModelType, JsonApiResponseMapperError>) {
        self.field = field
        self.objectMapper = objectMapper
    }
    
    override func map(_ response: JsonApiResponse) -> Result<[ModelType], MapperErrorType> {
        if response.statusCode != 0 {
            return .error(.invalidCode(response.statusCode, response.data))
        } else {
            guard let array = response.data[field] else {
                return .error(.fieldIsMissing(field))
            }
            if array.isArray() {
                var result = [ModelType]()
                for dict in array.array() {
                    switch objectMapper.map(dict) {
                    case .success(let model):
                        result.append(model)
                    case .error(let error):
                        return .error(.submapper(error))
                    }
                }
                return .success(result)
            } else {
                return .error(.unexpectedFieldType(field))
            }
        }
    }

    
}
