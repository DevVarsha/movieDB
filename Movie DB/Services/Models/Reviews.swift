//
//  Reviews.swift
//  Movie DB
//
//  Created by Varsha Soni on 01/07/25.
//

import Foundation

struct Reviews: Codable {
    
    let author: String
    let authorDetails: ReviewAutherDetails
    let content: String
    let id: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case id
        case url
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(String.self, forKey: .author)
       self.authorDetails = try container.decode(ReviewAutherDetails.self, forKey: .authorDetails)
        self.content = try container.decode(String.self, forKey: .content)
        self.id = try container.decode(String.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

