//
//  SimilarAndPopularTableViewCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 04/07/25.
//

import UIKit

class SimilarAndPopularTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SimilarAndPopularTableViewCell"
    static let nibName = "SimilarAndPopularTableViewCell"

    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var outerViewLayer: UIView!
    
    @IBOutlet weak var uiImage: UIImageView!
    
    @IBOutlet weak var uiTitleLabel: UILabel!
    
    @IBOutlet weak var uiGenrelabel: UILabel!
    
    @IBOutlet weak var uiReleaseDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(
            roundedRect: CGRect(origin: .init(x: 2, y: 2), size: .init(width: 40, height: 40)), cornerRadius: 40/2).cgPath
        borderLayer.strokeStart = 0
        borderLayer.strokeEnd = 1
        borderLayer.strokeColor = UIColor.gray.cgColor
        borderLayer.lineWidth = 8
        borderLayer.fillColor = UIColor.clear.cgColor
        
        outerViewLayer.layer.addSublayer(borderLayer)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(
            roundedRect: CGRect(origin: .init(x: 2, y: 2), size: .init(width: 40, height: 40)), cornerRadius: 40/2).cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.8
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        outerViewLayer.layer.addSublayer(shapeLayer)
        
        voteLabel.text = "73"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
