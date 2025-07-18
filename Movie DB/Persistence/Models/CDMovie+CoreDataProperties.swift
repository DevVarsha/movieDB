//
//  CDMovie+CoreDataProperties.swift
//  Movie DB
//
//  Created by Varsha Soni on 28/06/25.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var backdropPath: String
    @NSManaged public var genreIds: [Int64]
    @NSManaged public var id: Int64
    @NSManaged public var overview: String
    @NSManaged public var popularity: Float
    @NSManaged public var posterPath: String
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String
    @NSManaged public var voteAverage: Float
    @NSManaged public var voteCount: Int64

}

extension CDMovie : Identifiable {

}
