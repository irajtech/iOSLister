//
//  ViewController.swift
//  Lister
//
//  Created by Rajkumar Kothandaraman on 05/03/2021.
//

import UIKit

class ListViewController: UIViewController {

    internal var post = PostService()
    
    internal var posts: Post?
    
    @IBOutlet weak var postTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        postService()
        postTableView.estimatedRowHeight = 100
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.tableFooterView = UIView()
        postTableView.register(cellType: PostTableViewCell.self)
    }

}

