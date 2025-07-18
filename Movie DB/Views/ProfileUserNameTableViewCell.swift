//
//  ProfileUserNameTableViewCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import UIKit

class ProfileUserNameTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ProfileUserNameTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var subnameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
