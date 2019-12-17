//
//  URLRequestBuilderFactory.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct URLRequestBuilderFactory {
    
    static func makeURLRequestBuilder() -> URLRequestBuilder {
        return BaseURLRequestBuilder()
    }
    
}
