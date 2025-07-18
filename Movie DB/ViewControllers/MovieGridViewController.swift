//
//  MovieGridViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 26/06/25.
//

import UIKit

class MovieGridViewController: UIViewController {
    let movieViewModel = MovieGridViewModel()
    @IBOutlet weak var movieGridCollectionView: UICollectionView!
    
    @IBOutlet weak var gridBarView: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieGridCollectionView.delegate = self
        movieGridCollectionView.dataSource = self
        movieGridCollectionView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        movieGridCollectionView.register(UINib(nibName: MovieGridCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MovieGridCollectionViewCell.reuseIdentifier)
        
        movieViewModel.bind { state in
            switch state {
            case .initial:
                break
            case .loading:
                print("Loading...")
            case .loaded:
                self.movieGridCollectionView.reloadData()
            case .error(let error):
                print("Error: \(error)")
            }
        }
        
        movieViewModel.loadMovies()
    }
    
    
    @IBAction func gridBarButtonItem(_ sender: UIBarButtonItem) {
        //
    }
}

extension MovieGridViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieViewModel.saveToRecent(indexPath: indexPath)
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        viewController.movieDetailViewModel.movie = movieViewModel.getMovie(at: indexPath)
        // diffrent preset animation for ios >= 18
        viewController.preferredTransition = .zoom(sourceViewProvider: { context in
            let cell = collectionView.cellForItem(at: indexPath)
            return cell
        })
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}

extension MovieGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGridCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieGridCollectionViewCell
        
        movieViewModel.loadImage(at: indexPath) { image in
            cell.imageUiView.image = image
        }
        return cell
        
    }
}
