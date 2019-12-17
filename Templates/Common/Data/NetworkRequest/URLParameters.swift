//
//  URLParameters.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

public protocol URLParameters {
    var parameters: [String : String] { get set }
    
}

extension URLParameters {
    mutating func add(parameter: String, value: String) {
        parameters[parameter] = value
    }
    
    mutating func remove(parameter: String) {
        parameters.removeValue(forKey: parameter)
    }
}

public protocol URLParametersBuilder {
    func buildString(_ parameters: URLParameters) -> String
    func buildData(_ parameters: URLParameters) -> Data
    func buildStream(_ parameters: URLParameters) -> (InputStream, Int)
}
