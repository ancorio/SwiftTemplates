//
//  URLParametersBuilderFactory.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public class URLParametersBuilderFactory: NSObject {

    public static func makeURLParametersBuilder() -> URLParametersBuilder {
        return BaseURLParametersBuilder()
    }
}
