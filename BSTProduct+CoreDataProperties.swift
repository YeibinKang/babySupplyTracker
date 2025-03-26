//
//  BSTProduct+CoreDataProperties.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//
//

import Foundation
import CoreData


extension BSTProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BSTProduct> {
        return NSFetchRequest<BSTProduct>(entityName: "BSTProduct")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var memo: String?
    @NSManaged public var stage: String?
    @NSManaged public var inventoryQty: Int16
    @NSManaged public var name: String?
    @NSManaged public var expiryDate: Date?
    @NSManaged public var minStock: Int16
    @NSManaged public var updatedAt: Date?
    @NSManaged public var createdAt: Date?
    @NSManaged public var unit: String?
    @NSManaged public var category: BSTCategory?
    @NSManaged public var user: BSTAppUser?
    @NSManaged public var history: NSSet?

}

// MARK: Generated accessors for history
extension BSTProduct {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: BSTTrackerHistory)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: BSTTrackerHistory)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

extension BSTProduct : Identifiable {

}
