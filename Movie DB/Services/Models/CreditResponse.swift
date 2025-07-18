//
//  CreditResponse.swift
//  Movie DB
//
//  Created by Varsha Soni on 30/06/25.
//

import Foundation

struct CreditResponse: Codable {
    let id: Int
    let cast: [Credit]
}
