//
//  ProductRepository.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-18.
//

import Foundation
import CoreData
import UIKit

final class ProductRepository: CoreDataRepository, ProductRepositoryProtocol {
    
    
    
    typealias Entity = Product
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.viewContext){
        self.context = context
    }
    
    
    func create(_ entity: Product) throws {
        do{
            context.insert(entity)
            try context.save()
        }catch {
            print("Error occured while creating in Product Repository: \(error)")
            throw error
        }
    }
    
    func fetchAll() async throws -> [Product] {
        do{
            let request = NSFetchRequest<Product>(entityName: "Product")
            return try context.fetch(request)
        }catch{
            print("Error occured while fetching products in Product Repository: \(error)")
            throw error
        }
        
    }
    
    func fetchById(id: UUID) throws -> Product? {
        do{
            let request = NSFetchRequest<Product>(entityName: "Product")
            request.predicate = NSPredicate(format: "id == %@", id.uuidString)
            return try context.fetch(request).first
            
        }catch {
            print("Error occured while fetching products by Id in Product Repository: \(error)")
            throw error
        }
    }
    
    func fetchByCategory(_ category: Category) async throws -> [Product]{
        
        let request = NSFetchRequest<Product>(entityName: "Product")
        request.predicate = NSPredicate(format: "category == %@", category)
        return try context.fetch(request)
        
    }
    
    
    func save(_ entity: Product) throws {
        do{
            try context.save()
            
        }catch  {
            print("Error occured while saving products in Product Repository: \(error)")
            throw error
        }
    }
    
    
    func delete(_ entity: Product) throws {
        do{
            context.delete(entity)
            try context.save()
        }catch  {
            print("Error occured while deleting products by Id in Product Repository: \(error)")
            throw error
        }
    }
    
    func update(_product : Product) throws {
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", _product.id! as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingProduct = results.first {
                // 속성 업데이트
                existingProduct.name = _product.name
                existingProduct.stage = _product.stage
                existingProduct.needsRestock = _product.needsRestock
                existingProduct.minStock = _product.minStock
                existingProduct.memo = _product.memo
                existingProduct.inventoryQty = _product.inventoryQty
                existingProduct.expiryDate = _product.expiryDate
                existingProduct.updatedAt = _product.updatedAt
                
                // 컨텍스트 저장
                try context.save()
            } else {
                throw NSError(domain: "ProductRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Product not found"])
            }
        } catch {
            context.rollback()
            throw error
        }
        
    }
    
    func createNewProduct() -> Product {
        return Product(context: context)
    }
    
    
    
    
    
    
    
    
}
