//
//  File.swift
//  Lister
//
//  Created by Rajkumar Kothandaraman on 05/03/2021.
//

import Foundation


extension ListViewController {
    
    
  internal func postService() {
        
        post.fetchPosts { (posts, error) in
            guard let posts = posts else {
                return
            }
           
            let post = posts
        }
        
    }
    
    
}
