//
//  ReviewsViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import UIKit

class ReviewsViewController: UIViewController {

    let reviewViewModel = ReviewViewModel()
    
    @IBOutlet weak var uiTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTabelView.dataSource = self
        uiTabelView.delegate = self
        reviewViewModel.bind { state in
            switch state {
            case .initial:
                break
            case .loading:
                print("loading")
            case .loaded:
                self.uiTabelView.reloadData()
            case .error(let error):
                print("error\(error)")
            }
        }
        reviewViewModel.loadReview()
    }
}

extension ReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviewViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier) as! ReviewTableViewCell
            let reviews = reviewViewModel.getReviewCellData(indexPath: indexPath)
        cell.autherName.text = reviews.autherName
        cell.contentLabel.text = reviews.contentLabel
               return cell
    }
}

extension ReviewsViewController: UITableViewDelegate {
    
}
