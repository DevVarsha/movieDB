//
//  CreditsCollectionViewCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import UIKit

class CreditsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var uiImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var subNameLabel: UILabel!
    
    static let nibName = "CreditsCollectionViewCell"
    static let reuseIdentifier = "CreditsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
