//
//  PaginatedReviewResponse.swift
//  Movie DB
//
//  Created by Varsha Soni on 01/07/25.
//

import Foundation

struct PaginatedReviewResponse: Codable {
    let id: Int
    let page: Int
    let results: [Reviews]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
