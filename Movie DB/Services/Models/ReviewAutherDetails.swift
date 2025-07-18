//
//  ReviewAutherDetails.swift
//  Movie DB
//
//  Created by Varsha Soni on 01/07/25.
//

import Foundation


struct ReviewAutherDetails: Codable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarPath = try container.decodeIfPresent(String.self, forKey: .avatarPath)
        do {
            self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
        } catch{
            self.rating = nil
        }
    }
}
