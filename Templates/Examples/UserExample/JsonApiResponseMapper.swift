//
//  JsonApiResponseMapper.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct JsonApiResponseMapper: Mapper {
    
    let creator: Creator<JsonApiResponse>
    
    func map(_ from: NetworkJsonResponse) -> Result<JsonApiResponse, JsonApiResponseError> {
        
        switch from {
            case .json(let json, let head):
            if !json.isDictionary() {
                return .error(.invalidData("", "Expected dictionary json response.", head))
            }
            let dict = json.dictionary()
            guard let code = dict["code"] else {
                return .error(.invalidData("", "Expected 'code' key in json response.", head))
            }
            guard let message = dict["message"] else {
                return .error(.invalidData("", "Expected 'message' key in json response.", head))
            }
            guard let data = dict["data"] else {
                return .error(.invalidData("", "Expected 'data' key in json response.", head))
            }
            var result = creator.create()
            result.head = head
            result.statusCode = code.int32()
            result.message = message.string()
            result.data = data
            return .success(result)
        case .notJson(let data, let error, let head):
            return .error(.notJson(data, error, head))
        }
    }
}
