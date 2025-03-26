//
//  CategoryRepository.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-18.
//

import Foundation
import CoreData

class CategoryRepository: ObservableObject {
    
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func setupDefaultCategories() async throws{
        
        let defaultCategories = [
            "Hygiene Products",
            "Feeding Supplies",
            "Diapers",
            "Baby Clothing",
            "Sleep Products",
            "Baby Food",
            "Health Products",
            "Toys"
        ]
        
        for name in defaultCategories {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            let count = try? context.count(for: fetchRequest)
            
            if count == 0{
                createCategory(name: name, isDefault: true)
            }
        }
        
        do {
            try context.save()
            print("Default categories saved successfully!")
        } catch {
            print("Error while saving default categories: \(error)")
            throw error
        }
        
    }
    
    
    func createCategory(name: String, isDefault: Bool, order:Int? = nil) -> Category{
        let category = Category(context: context)
        category.name = name
        category.isDefault = isDefault
        category.id = UUID()
        
        if let order = order{
            category.order = Int16(order)
        }else{
            //create an order for the last order
            let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
            fetchRequest.fetchLimit = 1
            
            if let lastCategory = try? context.fetch(fetchRequest).first{
                category.order = lastCategory.order + 1
            }else{
                category.order = 0
            }
        }
        
        
        
        return category
    }
    
    func fetchAll() throws -> [Category] {
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "isDefault", ascending: false),
            NSSortDescriptor(key: "order", ascending: true)
        ]
        
        do{
            return try context.fetch(fetchRequest)
        }catch{
            print("Error while fetching Categories: \(error)")
            return []
        }
        
    }
    
}
