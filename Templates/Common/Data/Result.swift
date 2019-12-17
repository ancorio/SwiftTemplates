//
//  Result.swift
//  Templates
//
//  Created by user on 12/16/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

enum Result <ResultType, ErrorType: Error> {
    case success(ResultType)
    case error(ErrorType)
}
