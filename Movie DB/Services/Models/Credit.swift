//
//  Credit.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import Foundation

struct Credit: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int
    let character: String
    let creditId: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.gender = try container.decode(Int.self, forKey: .gender)
        self.id = try container.decode(Int.self, forKey: .id)
        self.knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        self.name = try container.decode(String.self, forKey: .name)
        self.originalName = try container.decode(String.self, forKey: .originalName)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        do {  self.profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        } catch {
            self.profilePath = nil
        }
        self.castId = try container.decode(Int.self, forKey: .castId)
        self.character = try container.decode(String.self, forKey: .character)
        self.creditId = try container.decode(String.self, forKey: .creditId)
        self.order = try container.decode(Int.self, forKey: .order)
    }
}
