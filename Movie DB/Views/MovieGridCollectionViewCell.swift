//
//  MovieGridCollectionViewCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 26/06/25.
//

import UIKit

class MovieGridCollectionViewCell: UICollectionViewCell {
    
    static let nibName = "MovieGridCollectionViewCell"
    static let reuseIdentifier = "MovieGridCollectionViewCell"
    

    @IBOutlet weak var imageUiView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

}

