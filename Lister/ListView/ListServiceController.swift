//
//  File.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import Foundation
import UIKit

extension ListViewController {
    
    
  internal func postService() {
        
    LoadingIndicator.sharedInstance.showLoaderonView(view: self.view)
        post.fetchPosts { (posts, error) in
            guard let posts = posts else {
                return
            }
           
            self.posts = posts
            DispatchQueue.main.async {
                LoadingIndicator.sharedInstance.removeLoader()
                self.postTableView.reloadData()
            }
        }
        
    }
    
    
}
