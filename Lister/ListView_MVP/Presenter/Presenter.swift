//
//  Presenter.swift
//  Lister_MVP
//
//  Created by Rajkumar Kothandaraman on 31/03/2021.
//

import Foundation


protocol DisplayData: NSObjectProtocol {
    func updateData(posts: [PostElement])
}


class ListPresenter {
    var postService: PostService
    weak private var displayDataDelegate: DisplayData?

    init(service: PostService) {
        self.postService = service
    }

    func setDelegate(displayDelegate: DisplayData) {
        self.displayDataDelegate = displayDelegate
    }

    func loadPresenter(pageNumber: Int) {

        postService.fetchPosts { (posts, error) in
            guard let posts = posts else {
                return
            }
            self.displayDataDelegate?.updateData(posts: posts)
        }
    }
}
