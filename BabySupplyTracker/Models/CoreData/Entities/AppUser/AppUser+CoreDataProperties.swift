//
//  AppUser+CoreDataProperties.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var email: String?
    @NSManaged public var pw: String?
    @NSManaged public var role: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var history: NSSet?
    @NSManaged public var product: NSSet?

}

// MARK: Generated accessors for history
extension AppUser {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: TrackerHistory)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: TrackerHistory)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

// MARK: Generated accessors for product
extension AppUser {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: Product)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: Product)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}

extension AppUser : Identifiable {

}
