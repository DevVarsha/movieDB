//
//  TrailersViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import UIKit

class TrailersViewController: UIViewController {

    
    @IBOutlet weak var uiTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // registr xib
        uiTableView.register(UINib(nibName: SimilarAndPopularTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: SimilarAndPopularTableViewCell.reuseIdentifier)
        
    }
}
