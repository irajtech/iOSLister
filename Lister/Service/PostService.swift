//
//  PostService.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import Foundation


struct PostService: Environment {
    
    internal var serviceType: ServiceType
    
    init(pageNumber: Int = 10) {
        serviceType = ServiceType.post(pageNumber)
    }
    
    func fetchPosts(completion: (([PostElement]?, Error?) -> Void)?) {
        let resource = Resource(method: .get, headers: [:], url: resourceURL)
        Service<[PostElement]>.perform(resource) { result in
            switch result {
            case .success(let result):
                completion?(result, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }.resume()
    }
}
