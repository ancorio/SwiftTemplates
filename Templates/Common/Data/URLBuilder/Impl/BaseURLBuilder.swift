//
//  BaseURLBuilder.swift
//  Templates
//
//  Created by user on 12/11/19.
//  Copyright © 2019 Igor Shavlovsky. All rights reserved.
//

import UIKit

struct BaseURLBuilder: URLBuilder {
    
    var scheme: URLScheme
    var domain: String
    var path: String
    var parameters: [String : String]
    var parametersBuilder: URLParametersBuilder
    
    func url() -> URL {
        var string = "\(scheme.asString())://\(domain)/\(path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
        let parametersString = parametersBuilder.buildString(self)
        if parametersString.count > 0 {
            string = string + "?" + parametersString
        }
        return URL(string: string)!
    }

}
