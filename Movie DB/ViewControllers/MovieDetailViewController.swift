//
//  MovieDetailViewController.swift
//  Movie DB
//
//  Created by Varsha Soni on 29/06/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let movieDetailViewModel = MovieDetailViewModel()
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var outlineProgressView: UIView!
    
    @IBOutlet weak var overlayProgressView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieDetails()
    }
    
    @IBAction func onClickMenu(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Memory", message: nil, preferredStyle: .actionSheet)
        
        let shareAction = UIAlertAction(title: "Share this movie!", style: .default) { _ in
            // Share logic
            print("Share tapped ")
            self.movieDetailViewModel.loadImage(at: "posterPath") { image in
                guard let sharableImage = image else {
                    print("Failed to load image")
                    return
                }
                // Now you can use sharableImage here, e.g., show share sheet
                let activityVC = UIActivityViewController(activityItems: [sharableImage], applicationActivities: nil)
                DispatchQueue.main.async {
                    print("get image\(sharableImage)")
                    self.present(activityVC, animated: true, completion: nil)
                }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(shareAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    @IBAction func onReviewTap(_ sender: UITapGestureRecognizer) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController else {
            return
        }
        viewController.reviewViewModel.movieId = movieDetailViewModel.movie.id
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func onTrailerTap(_ sender: UITapGestureRecognizer) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "TrailersViewController") as? TrailersViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func onCreditsTap(_ sender: UITapGestureRecognizer) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "CreditsViewController") as? CreditsViewController else {
            return
        }
        
        viewController.creditViewModel.movieId = movieDetailViewModel.movie.id
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func onSimilarTap(_ sender: UITapGestureRecognizer) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SimilarAndPopularViewController") as? SimilarAndPopularViewController else {
            return
        }
        viewController.moviesViewModel.movieId = movieDetailViewModel.movie.id
        viewController.moviesViewModel.navigationBarTitle = "Similar movies"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setMovieDetails() {
        
        movieDetailViewModel.loadImage(at: "posterPath") { image in
            self.posterImage.image = image
        }
        
        movieDetailViewModel.loadImage(at: "bannerImage") { image in
            self.bannerImage.image = image
        }
        
        let movie = movieDetailViewModel.movie
        
        overViewLabel.text = movie?.overview
        memoryLabel.text = movie?.title
        voteAverageLabel.text = String(format: "%.1f", movie?.voteAverage ?? 0.0)
        releaseDateLabel.text = movie?.releaseDate?.formatted(date: .numeric, time: .omitted)
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(
            roundedRect: CGRect(origin: .init(x: 2, y: 2), size: .init(width: 40, height: 40)), cornerRadius: 40/2).cgPath
        borderLayer.strokeStart = 0
        borderLayer.strokeEnd = 1
        borderLayer.strokeColor = UIColor.gray.cgColor
        borderLayer.lineWidth = 8
        borderLayer.fillColor = UIColor.clear.cgColor
        
        overlayProgressView.layer.addSublayer(borderLayer)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(
            roundedRect: CGRect(origin: .init(x: 2, y: 2), size: .init(width: 40, height: 40)), cornerRadius: 40/2).cgPath
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.8
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        overlayProgressView.layer.addSublayer(shapeLayer)
        
    }
}

