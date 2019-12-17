//
//  BaseNetworkResponseToJsonResponse.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

#warning("Cover with tests")
public struct BaseNetworkResponseToJsonResponse: NetworkResponseToJsonResponse {
    public func serialize(_ response: NetworkResponse) throws -> JsonEntity {
        return try JSONSerialization.jsonEntity(data: response.responseData())
    }
}
