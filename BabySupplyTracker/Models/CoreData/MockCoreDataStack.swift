//
//  MockCoreDataStack.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-03-09.
//

import Foundation
import CoreData

// CoreData Mock 객체 생성
class MockCoreDataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BabySupplyTracker")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
