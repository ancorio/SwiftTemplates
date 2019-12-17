//
//  URLBuilder.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public protocol URLBuilder: URLParameters {
    var scheme: URLScheme { get set }
    var domain: String { get set }
    var path: String { get set }
    func url() -> URL
}
