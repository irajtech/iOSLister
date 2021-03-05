//
//  ParameterEncoding.swift
//  Lister
//
//  Created by Rajkumar Kothandaraman on 05/03/2021.
//

import Foundation


public enum RequestParameters {
    case form([String: Encodable])
    case body(Data)
    case url([String: Encodable])

    
    public static func none() -> RequestParameters {
        return self.url([:])
    }
}

func stringFromParameters(parameters: [String: Encodable], escaped: Bool = false) -> String {
    return parameters.map { (key, value) -> String in
        if escaped {
            let val = "\(value)".escapedQuery
            return "\(key.escapedQuery)=\(val)"
        } else {
            return "\(key)=\(value)"
        }
    }.joined(separator: "&")
}
