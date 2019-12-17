//
//  URLBuilderFactory.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct URLBuilderFactory {
    static func makeURLBuilder() -> URLBuilder {
        return BaseURLBuilder(scheme: BaseURLScheme.https, domain: "", path: "", parameters: [:], parametersBuilder: URLParametersBuilderFactory.makeURLParametersBuilder())
    }
}
