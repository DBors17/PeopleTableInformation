//
//  CDChampion+CoreDataProperties.swift
//  PeopleTableInformation
//
//  Created by Dorin on 23.05.2025.
//
//

import Foundation
import CoreData


extension CDChampion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChampion> {
        return NSFetchRequest<CDChampion>(entityName: "CDChampion")
    }

    @NSManaged public var gallery: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var position: String?
    @NSManaged public var role: String?
    @NSManaged public var ultimate: String?
    @NSManaged public var url: String?
    @NSManaged public var favorite: CDFavorite?

}

extension CDChampion : Identifiable {

}
