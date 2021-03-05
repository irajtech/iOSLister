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
        
        return posts?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(for: indexPath) as PostTableViewCell
        
        guard let posts = posts else {
            return cell
        }
        
        let post: PostElement =  posts[indexPath.row]
        cell.titleName.text =  post.title
        cell.messageBody.text = post.body
        return cell
    }
    
    
}
