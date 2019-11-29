//
//  RepositoryCache.swift
//  Templates
//
//  Created by Igor Shavlovsky on 11/28/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

protocol RepositoryCache {
    associatedtype RepositoryType: Repository
    var repository: RepositoryType {get}
    // init with repository?
}

