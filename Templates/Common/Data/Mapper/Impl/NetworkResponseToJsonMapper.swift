//
//  NetworkResponseToJsonMapper.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit


enum NetworkJsonResponse {
    case json(JsonEntity, NetworkResponseHead)
    case notJson(Data, JsonSerializationError, NetworkResponseHead)
}

enum NetworkResponseToJsonMapperError: Error {
    case invalidData(NetworkResponseHead)
}

typealias NetworkResponseToJsonResult = Result<NetworkJsonResponse, NetworkResponseToJsonMapperError>

struct NetworkResponseToJsonMapper: Mapper {

    typealias FromType = NetworkResponse
    typealias ToType = NetworkJsonResponse
    typealias MapperErrorType = NetworkResponseToJsonMapperError
    
    func map(_ response: NetworkResponse) -> NetworkResponseToJsonResult {
        guard let data = response.responseData() else {
            return .error(.invalidData(response))
        }
        do {
            let result = try JSONSerialization.jsonEntity(data: data)
            return .success(.json(result, response))
        } catch let e {
            return .success(.notJson(data, e, response))
        }
    }
    

}
