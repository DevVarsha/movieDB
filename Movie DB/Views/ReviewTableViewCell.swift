//
//  ReviewTableViewCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 01/07/25.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ReviewTableViewCell"

    @IBOutlet weak var autherName: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
