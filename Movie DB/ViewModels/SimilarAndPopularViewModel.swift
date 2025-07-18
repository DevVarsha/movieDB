//
//  SimilarAndPopularViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 15/07/25.
//

import Foundation
import UIKit

class SimilarAndPopularViewModel {
    
    var navigationBarTitle = ""
    var movieId: Int = 0
    var titleOfApiEndPoint = ""
    
    func getNavigationTitle() {
        switch navigationBarTitle {
        case "Popular Movies":
            titleOfApiEndPoint =  "popular"
        case "Top Rated Movies":
            titleOfApiEndPoint = "top_rated"
        case "Similar movies":
            titleOfApiEndPoint = "\(movieId)/similar"
        default:
            print("default")
        }
    }
    
    enum State {
        case initial
        case loading
        case loaded
        case error(Error)
    }
    
    private var movies: [Movie] = []
    var state: State = .initial {
        didSet {
            onChange?(state)
        }
    }
    
    var onChange: ((State) -> Void)?
    
    func bind(onChange: @escaping (State) -> Void) {
        self.onChange = onChange
    }

    func loadSimilarMovies() {
        state = .loading
        MovieService.shared.fetchUpcoming(apiTitle: titleOfApiEndPoint) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.state = .loaded
                }
            case .failure(let failure):
                self.state = .error(failure)
            }
        }
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    struct MovieDisplayData {
        let title: String
        let voteLabel: String
        let posterPath: String
        let releaseDate: String?
    }
    
    func getCellData(at indexPath: IndexPath) -> MovieDisplayData {
        let movie = movies[indexPath.row]
        return MovieDisplayData(
            title: movie.title,
            voteLabel: String(format: "%.1f", movie.voteAverage),
            posterPath: movie.posterPath,
            releaseDate: movie.releaseDate?.formatted(date: .numeric, time: .omitted)
        )
    }
    
    func loadImage(at posterPath: String, completion: @escaping (UIImage?) -> Void) {

        MovieService.shared.fetchImage(path: posterPath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let failure):
                completion(nil)
            }
        }
    }
    
}
