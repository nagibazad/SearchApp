//
//  Bookmark+CoreDataProperties.swift
//  
//
//  Created by Nagib Azad on 22/11/18.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var imageUrl: URL?
    @NSManaged public var pageUrl: URL?
    @NSManaged public var pageId: Int64
    @NSManaged public var title: String?

}
