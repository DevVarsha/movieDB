//
//  SimilarAndPopularViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 04/07/25.
//

import UIKit

class SimilarAndPopularViewController: UIViewController {
    
    let moviesViewModel = SimilarAndPopularViewModel()
    
    @IBOutlet weak var uiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel.getNavigationTitle()
        self.title = moviesViewModel.navigationBarTitle
        // registr xib
        uiTableView.register(UINib(nibName: SimilarAndPopularTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: SimilarAndPopularTableViewCell.reuseIdentifier)
        
        uiTableView.delegate = self
        uiTableView.dataSource = self
        
        moviesViewModel.bind { state in
            switch state {
            case .initial:
                break
            case .loading:
                print("api loadig")
            case .loaded:
                self.uiTableView.reloadData()
            case .error(let error):
                print("facing error\(error)")
            }
        }
        moviesViewModel.loadSimilarMovies()
    }
}


extension SimilarAndPopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.getMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimilarAndPopularTableViewCell.reuseIdentifier, for: indexPath) as! SimilarAndPopularTableViewCell
        
        let getCellRowData = moviesViewModel.getCellData(at : indexPath)
        
        cell.uiTitleLabel.text = getCellRowData.title
        cell.uiGenrelabel.text = "Action"
        cell.uiReleaseDateLabel.text = getCellRowData.releaseDate
        let posterPath = getCellRowData.posterPath

        moviesViewModel.loadImage(at: posterPath) { image in
            cell.uiImage.image = image
        }
        return cell
    }
}

extension SimilarAndPopularViewController: UITableViewDelegate {
    
}
