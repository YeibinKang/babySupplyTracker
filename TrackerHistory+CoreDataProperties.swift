//
//  TrackerHistory+CoreDataProperties.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//
//

import Foundation
import CoreData


extension TrackerHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerHistory> {
        return NSFetchRequest<TrackerHistory>(entityName: "TrackerHistory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var qtyChange: Int16
    @NSManaged public var type: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var note: String?
    @NSManaged public var user: AppUser?
    @NSManaged public var product: Product?

}

extension TrackerHistory : Identifiable {

}
