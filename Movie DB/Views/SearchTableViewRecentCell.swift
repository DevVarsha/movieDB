//
//  SearchTableViewRecentCell.swift
//  Movie DB
//
//  Created by Varsha Soni on 29/06/25.
//

import UIKit

class SearchTableViewRecentCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchTableViewRecentCell"

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        
        collectionView.register(UINib(nibName: MovieGridCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MovieGridCollectionViewCell.reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SearchTableViewRecentCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieGridCollectionViewCell
        cell.contentView.backgroundColor = .systemBlue
        let posterPath = movies[indexPath.row].posterPath
        MovieService.shared.fetchImage(path: posterPath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageUiView.image = image
                }
            case .failure(let failure):
                print(failure)
            }
        }
        return cell
        
    }
}

extension SearchTableViewRecentCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}
