//
//  Movie.swift
//  Movie DB
//
//  Created by Varsha Soni on 27/06/25.
//

import Foundation

struct Movie: Codable {
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let overview: String
    let popularity: Float
    let posterPath: String
    let releaseDate: Date?
    let title: String
    let voteAverage: Float
    let voteCount: Int
    
    init(backdropPath: String, genreIds: [Int], id: Int, overview: String, popularity: Float, posterPath: String, releaseDate: Date?, title: String, voteAverage: Float, voteCount: Int) {
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.id = try container.decode(Int.self, forKey: .id)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Float.self, forKey: .popularity)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        do {
            self.releaseDate = try container.decodeIfPresent(Date.self, forKey: .releaseDate)
        } catch {
            self.releaseDate = nil
        }
        self.title = try container.decode(String.self, forKey: .title)
        self.voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
    
}
