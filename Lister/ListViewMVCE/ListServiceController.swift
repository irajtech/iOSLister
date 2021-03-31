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
       PostService(pageNumber: pageNumber).fetchPosts { (posts, error) in
            guard let postData = posts else {
                return
            }
            
            self.loadingStatus = postData.count > 1 ? .haveMore : .finished
            self.posts.append(contentsOf: postData)
            DispatchQueue.main.async {
                LoadingIndicator.sharedInstance.removeLoader()
                self.postTableView.reloadData()
            }
        }
    }


}
