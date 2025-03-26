//
//  BSTCategory+CoreDataProperties.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//
//

import Foundation
import CoreData


extension BSTCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BSTCategory> {
        return NSFetchRequest<BSTCategory>(entityName: "BSTCategory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var memo: String?
    @NSManaged public var product: NSSet?

}

// MARK: Generated accessors for product
extension BSTCategory {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: BSTProduct)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: BSTProduct)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}

extension BSTCategory : Identifiable {

}
