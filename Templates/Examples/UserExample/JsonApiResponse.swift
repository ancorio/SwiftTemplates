//
//  ApiResponse.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

indirect enum JsonApiResponseMapperError: Error {
    case fieldIsMissing(String)
    case invalidFieldType(String)
    case unexpectedFieldType(String)
    case invalidCode(Int32, JsonEntity)
    case submapper(JsonApiResponseMapperError)
}

enum JsonApiResponseError: Error {
    case invalidData(String, JsonEntity, NetworkResponseHead)
    case notJson(Data, JsonSerializationError, NetworkResponseHead)
}

struct JsonApiResponse {
    var head: NetworkResponseHead!
    var statusCode: Int32!
    var message: String!
    var data: JsonEntity!
}

class JsonApiResponseCreator: Creator<JsonApiResponse> {
    override func create() -> JsonApiResponse {
        return JsonApiResponse()
    }
}
