//
//  PaginatedMovieResponse.swift
//  Movie DB
//
//  Created by Varsha Soni on 27/06/25.
//

import Foundation

struct PaginatedMovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    
}


