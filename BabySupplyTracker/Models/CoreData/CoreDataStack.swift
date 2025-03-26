//
//  CoreDataStack.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "BabySupplyTracker")
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    // Preview용 인스턴스 추가
        static var preview: CoreDataStack = {
            let stack = CoreDataStack(inMemory: true)
            let viewContext = stack.persistentContainer.viewContext
            
            // 샘플 Product 데이터 생성 (Item 대신 Product 사용)
            for _ in 0..<10 {
                let newProduct = Product(context: viewContext)
                newProduct.name = "Sample Baby Product"
                newProduct.createdAt = Date()
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            return stack
        }()
        
        // In-Memory 옵션 추가
        init(inMemory: Bool = false) {
            if inMemory {
                persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            }
        }
        
        // Context 접근 메서드 (옵션)
        var viewContext: NSManagedObjectContext {
            persistentContainer.viewContext
        }
        
        // 데이터 저장 메서드 (옵션)
        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        private init() { }
}
