//
//  History+CoreDataProperties.swift
//  
//
//  Created by Nagib Azad on 22/11/18.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var imageUrl: URL?
    @NSManaged public var pageId: Int64
    @NSManaged public var pageUrl: URL?
    @NSManaged public var title: String?
    @NSManaged public var time: NSDate?

}
