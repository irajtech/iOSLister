//
//  Resource.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import Foundation

public struct Resource {
    
    let method: HTTPMethod
    let headers: [String: String]
    let parameters: RequestParameters
    let url: URL
    let data:Data?
    
    public init(method: HTTPMethod,  headers: [String: String], parameters: RequestParameters = .none(), url: URL, data: Data? = nil) {
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.url = url
        self.data = data
    }
}
