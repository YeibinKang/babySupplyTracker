//
//  Product+CoreDataProperties.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-18.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
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
    @NSManaged public var needsRestock: Bool
    @NSManaged public var category: Category?
    @NSManaged public var user: AppUser?
    @NSManaged public var history: NSSet?

}

// MARK: Generated accessors for history
extension Product {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: TrackerHistory)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: TrackerHistory)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

extension Product : Identifiable {

}
