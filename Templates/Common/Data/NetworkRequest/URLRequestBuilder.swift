//
//  URLRequestBuilder.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol URLRequestBuilder {

    func build(_: NetworkRequest) -> URLRequest
}
