//
//  Environment.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import Foundation


protocol Environment {
    var standardHeaders: [String: String] { get }
    var baseUrl: URL { get }
    var serviceType: ServiceType { get }
    var resourceURL: URL { get }
}

extension Environment {
    var standardHeaders: [String: String] {
        #if DEBUG || BETA
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        #else
        return [
           "Accept": "application/json",
           "Content-Type": "application/json"
        ]
        #endif
    }
    
    var baseUrl: URL {
        #if DEBUG
            return APIEnvironment.debug.baseURL
        #elseif BETA
            return APIEnvironment.beta.baseURL
        #else
            return APIEnvironment.release.baseURL
        #endif
    }
    
    var resourceURL: URL {
        switch serviceType {
        case .post(_):
             return baseUrl.appendingPathComponent("/posts")
        case .comment:
            return baseUrl.appendingPathComponent("/comments")
        }
    }
}


private enum APIEnvironment {
    case debug, beta, release
    
    var baseURL: URL {
        switch self {
        case .debug:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        case .beta:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        case .release:
            return URL(string: "https://jsonplaceholder.typicode.com")!
        }
    }
}



