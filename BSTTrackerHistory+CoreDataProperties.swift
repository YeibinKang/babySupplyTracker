//
//  BSTTrackerHistory+CoreDataProperties.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//
//

import Foundation
import CoreData


extension BSTTrackerHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BSTTrackerHistory> {
        return NSFetchRequest<BSTTrackerHistory>(entityName: "BSTTrackerHistory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var qtyChange: Int16
    @NSManaged public var type: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var note: String?
    @NSManaged public var user: BSTAppUser?
    @NSManaged public var product: BSTProduct?

}

extension BSTTrackerHistory : Identifiable {

}
