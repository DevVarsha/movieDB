//
//  SearchViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 18/07/25.
//
import Foundation
import UIKit


class SearchViewModel {
    struct MovieGroup {
        let title: String
        let subtitle: String
    }
    
    enum Section {
        case recentlyVisited([Movie])
        case movieGroups([MovieGroup]) //enum associated properties
        case genres([Genre])
    }
    
    var sections = [
        Section.movieGroups([
            MovieGroup(title: "Popular movies", subtitle: "The hottest movies on the internet"),
            MovieGroup(title: "Top rated movies", subtitle: "The top rated movies on the internet"),
        ])
    ]
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum State {
        case initial
        case loading
        case loaded
        case error(Error)
    }
    
    var state: State = .initial {
        didSet {
            onChange?(state)
        }
    }
    
    var onChange: ((State) -> Void)?
    
    func bind(onChange: @escaping (State) -> Void) {
        self.onChange = onChange
    }
    
    func loadGenres() {
        state = .loading
        MovieService.shared.fetchGenres { result in
            switch result {
            case .success(let genres):
                self.sections.append(.genres(genres))
                self.state = .loaded
                DispatchQueue.main.async {
                }
            case .failure(let failure):
                print(failure)
                self.state = .error(failure)
            }
        }
    }
    
   
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .recentlyVisited(let recentMovies): return recentMovies.count > 0 ? 1 : 0
        case .movieGroups(let groups): return groups.count
        case .genres(let genres): return genres.count
        }
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        let section = sections[section]
        switch section {
        case .recentlyVisited: return "RECENT MOVIES"
        case .movieGroups: return ""
        case .genres: return "MOVIE GENRES"
        }
    }

    
    func loadRecentlyVisitedMovies() {
        state = .loading
        let fetchRequest = CDMovie.fetchRequest()
        do {
            let cdMovies = try viewContext.fetch(fetchRequest)
            let movies = cdMovies.map { cdMovie in
                return Movie(
                    backdropPath: cdMovie.backdropPath,
                    genreIds: cdMovie.genreIds.map(Int.init),
                    id: Int(cdMovie.id),
                    overview: cdMovie.overview,
                    popularity: cdMovie.popularity,
                    posterPath: cdMovie.posterPath,
                    releaseDate: cdMovie.releaseDate,
                    title: cdMovie.title,
                    voteAverage: cdMovie.voteAverage,
                    voteCount: Int(cdMovie.voteCount)
                )
            }
            print(movies)
            // for preventing multiple insert using this condition
            if case .recentlyVisited = sections[0]{
                sections[0] = Section.recentlyVisited(movies)
            }
            else {
                sections.insert(.recentlyVisited(movies), at: 0)
            }
            state = .loaded
        } catch{
            print(error)
            state = .error(error)
        }
    }
}
