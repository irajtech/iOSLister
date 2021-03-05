//
//  Request.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import Foundation


public func request(resource: Resource) -> URLRequest {
    
    let url = resource.url
    
    var request = URLRequest(url: url)
    
    switch resource.parameters {
    case .url(let params):
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        var items = [URLQueryItem]()
        for (key, val) in params {
            items.append(
                URLQueryItem(name: key, value: "\(val)")
            )
        }
        if items.count > 0 {
            components?.queryItems = items
        }
        
        request.url = components?.url
    case .body(let data):
        request.httpBody = data
    case .form(let params):
        request.httpBody = stringFromParameters(parameters: params).data(using: String.Encoding.utf8)
    }
    
    request.allHTTPHeaderFields = resource.headers
    
    request.httpMethod = resource.method.rawValue
    
    return request
}
