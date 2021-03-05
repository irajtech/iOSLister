//
//  ViewController.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import UIKit

class ListViewController: UIViewController {

    internal var posts: Post = [PostElement]()
    internal var pageNumber = 20
    
    var loadingStatus = LoadMoreStatus.haveMore
    
    @IBOutlet weak var postTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        postService()
        postTableView.estimatedRowHeight = 100
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.tableFooterView = UIView()
        postTableView.register(cellType: PostTableViewCell.self)
    }

}

