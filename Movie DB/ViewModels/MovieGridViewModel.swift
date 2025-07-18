//
//  MovieGridViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 13/07/25.
//
import Foundation
import UIKit

class MovieGridViewModel {
    
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
    
    func loadMovies() {
        state = .loading
        // use singleton
        MovieService.shared.fetchUpcoming(apiTitle: "upcoming") { result in
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
    
    func loadImage(at indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        let posterPath = movies[indexPath.row].posterPath
        MovieService.shared.fetchImage(path: posterPath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let failure):
                print(failure)
                completion(nil)
            }
        }
    }
    
    func saveToRecent(indexPath: IndexPath) {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchrequest = CDMovie.fetchRequest()
        let obj =  self.movies[indexPath.row]
        fetchrequest.predicate = NSPredicate(format: "id == %d", obj.id)
        do {
            let movieWithId = try viewContext.fetch(fetchrequest)
            if movieWithId.count == 0 {
                viewContext.perform {
                    let cdMovie = CDMovie(context: viewContext)
                    cdMovie.id = Int64(obj.id)
                    cdMovie.title = obj.title
                    cdMovie.overview = obj.overview
                    cdMovie.backdropPath = obj.backdropPath
                    cdMovie.posterPath = obj.posterPath
                    cdMovie.releaseDate = obj.releaseDate
                    cdMovie.voteAverage = obj.voteAverage
                    cdMovie.voteCount = Int64(obj.voteCount)
                    cdMovie.genreIds = obj.genreIds.map(Int64.init)
                    cdMovie.popularity = obj.popularity
                }
                try viewContext.save()
            }
            
        } catch {
            print(error)
        }
    }
    
    func getMovie(at indexPath: IndexPath ) -> Movie {
        return movies[indexPath.row]
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
}
