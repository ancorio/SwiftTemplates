//
//  NetworkRequestStub.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct NetworkRequestStub: NetworkRequest {
    
    var httpMethod: HttpMethod = .get
    
    var headers: HttpHeaders = BaseHttpHeaders(allHeaderFields: [:])
    
    var urlBuilder: URLBuilder = BaseURLBuilder(scheme: BaseURLScheme.https, domain: "example.com", path: "path", parameters: [:], parametersBuilder: BaseURLParametersBuilder())
    
    var body: NetworkRequestBody? = nil
    

}
