//
//  TrailerTableViewCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 16/07/25.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let reuseIdentifier = "TrailerTableViewCell"
    static let nibName = "TrailerTableViewCell"
    
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var trailerImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
