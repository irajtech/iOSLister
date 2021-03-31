//
//  File.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import UIKit

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(for: indexPath) as PostTableViewCell

        
        let post: PostElement =  posts[indexPath.row]
        cell.configureCell(post: post)
        
        // Check if the last row number is the same as the last current data element
        if indexPath.row == posts.count - 1 {
            if loadingStatus == .haveMore {
                loadingStatus = .loading
                self.loadMore()
            }
        }
        return cell
    }
    
    func loadMore()  {
        pageNumber = pageNumber + 10
        self.postService()
    }
    
}
