//
//  PostcellTableViewCell.swift
//  Lister
//
//  Created by Raj on 05/03/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleName: UILabel!
    
    @IBOutlet weak var messageBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: PostElement) {
        self.titleName.text =  post.title
        self.messageBody.text = post.body
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
