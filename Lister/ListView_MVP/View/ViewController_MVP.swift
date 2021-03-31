//
//  ViewController_MVP.swift
//  Lister_MVP
//
//  Created by Rajkumar Kothandaraman on 31/03/2021.
//

import UIKit

class ViewController_MVP: UIViewController, DisplayData {
    
    private let presenter = ListPresenter(service: PostService())
    @IBOutlet weak var postTableView: UITableView!
    var loadingStatus = LoadMoreStatus.haveMore
    private var postModel: Post = [PostElement]()
    private var pageNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.setDelegate(displayDelegate: self)
        presenter.loadPresenter(pageNumber: pageNumber)
        postTableView.estimatedRowHeight = 100
        postTableView.dataSource = self
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.tableFooterView = UIView()
        postTableView.register(cellType: PostTableViewCell.self)
        LoadingIndicator.sharedInstance.showLoaderonView(view: self.view)
    }
    
    func updateData(posts: [PostElement]) {
        self.loadingStatus = posts.count > 1 ? .haveMore : .finished
        self.postModel.append(contentsOf: posts)
        DispatchQueue.main.async {
            LoadingIndicator.sharedInstance.removeLoader()
            self.postTableView.reloadData()
        }
    }
}


extension ViewController_MVP: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(for: indexPath) as PostTableViewCell

        
        let post: PostElement =  postModel[indexPath.row]
        cell.configureCell(post: post)
        
        // Check if the last row number is the same as the last current data element
        if indexPath.row == postModel.count - 1 {
            if loadingStatus == .haveMore {
                loadingStatus = .loading
                self.loadMore()
            }
        }
        return cell
    }
    
    func loadMore()  {
        //pageNumber = pageNumber + 10
        presenter.loadPresenter(pageNumber: 10)
    }
    
}
