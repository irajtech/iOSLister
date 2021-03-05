//
//  PostcellTableViewCell.swift
//  Lister
//
//  Created by Rajkumar Kothandaraman on 05/03/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleName: UILabel!
    
    @IBOutlet weak var messageBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
