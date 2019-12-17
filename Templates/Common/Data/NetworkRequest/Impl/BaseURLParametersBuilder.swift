//
//  BaseURLParametersBuilder.swift
//  Templates
//
//  Created by user on 12/12/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct BaseURLParametersBuilder: URLParametersBuilder {
    
    func buildData(_ parameters: URLParameters) -> Data {
        return buildString(parameters).data(using: .ascii)!
    }
    
    func buildStream(_ parameters: URLParameters) -> (InputStream, Int) {
        let data = buildData(parameters)
        return (InputStream(data: data), data.count)
    }
    

    func buildString(_ parameters: URLParameters) -> String {
        return parameters.parameters.map { (key: String, value: String) -> String in
            return key + "=" + value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            }.joined(separator: "&")
    }
    
}
