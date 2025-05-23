//
//  CDFavorite+CoreDataProperties.swift
//  PeopleTableInformation
//
//  Created by Dorin on 23.05.2025.
//
//

import Foundation
import CoreData


extension CDFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavorite> {
        return NSFetchRequest<CDFavorite>(entityName: "CDFavorite")
    }

    @NSManaged public var champion: CDChampion?

}

extension CDFavorite : Identifiable {

}
