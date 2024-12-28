//
//  ConsumableTableViewCell.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 3.5.24.
//

import UIKit

class ConsumableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    static let identifier = "ConsumableTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ConsumableTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
