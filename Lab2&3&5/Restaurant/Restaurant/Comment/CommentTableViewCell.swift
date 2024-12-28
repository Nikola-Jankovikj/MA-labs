//
//  CommentTableViewCell.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 5.5.24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var comment: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "CommentTableViewCell", bundle: nil)
    }
    
    static let identifier = "CommentTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
