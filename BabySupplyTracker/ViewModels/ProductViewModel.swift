//
//  ProductViewModel.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-18.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class ProductViewModel: ObservableObject{
    
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category? = nil
    
    private var repository: ProductRepository
    private var categoryRepository: CategoryRepository
    
    
    init(repository: ProductRepository = ProductRepository(), categoryRepository: CategoryRepository){
        self.repository = repository
        self.categoryRepository = categoryRepository
    }
    
    func loadCategories() async {
        do {
            categories = try categoryRepository.fetchAll()
            if categories.isEmpty {
                try await categoryRepository.setupDefaultCategories()
                categories = try categoryRepository.fetchAll()
            }
            print("Loaded categories: \(categories.map { $0.name ?? "nil" })")
        } catch {
            print("Error loading categories: \(error)")
        }
    }
    
    
    //sorting by category
    func loadProductsByCategory() async throws{
        isLoading = true
        
        do{
            let fetchedProducts: [Product]
            // find selected category name
            // check products with selected category name
            
            if let category = selectedCategory{
                fetchedProducts = try await repository.fetchByCategory(category)
            }else{
                fetchedProducts = try await repository.fetchAll()
            }
            
            await MainActor.run {
                self.products = fetchedProducts
                self.objectWillChange.send()
            }
            
        
        }catch{
            print("Error loading products: \(error)")
            throw error
        }
    }
    
    func updateCategory(_ category: Category?){
        self.selectedCategory = category
        Task{
            try await loadProductsByCategory()
        }
    }
    
    //read all products
    func readProducts() async throws{
        isLoading = true
        
        do {
                let fetchedProducts = try await repository.fetchAll()
                
                // 메인 스레드에서 UI 업데이트
                await MainActor.run {
                    self.products = fetchedProducts
                    self.objectWillChange.send() // 명시적으로 변경 알림
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to load products: \(error.localizedDescription)"
                }
                print("Error has occurred while reading products: \(error)")
                throw error
            }
            
            await MainActor.run {
                isLoading = false
            }
    }
    
    
    //create an object
    func createProduct(name: String, stage: String, needsRestock: Bool, minStock: Int16, memo: String, inventoryQty: Int16, expiryDate: Date, createdAt: Date, updatedAt: Date, unit: String, category: Category) async throws{
        
        //check data validity
        guard !name.isEmpty else {
            errorMessage = "Product name cannot be empty"
            return
        }
        guard !stage.isEmpty else {
            errorMessage = "Product stage cannot be empty"
            return
        }
        guard inventoryQty >= 0 else {
            errorMessage = "Product inventory qty cannot be negative"
            return
        }
        
        
        //create an object
        //use Product Repository
        let newProduct = repository.createNewProduct()
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.stage = stage
        newProduct.needsRestock = false
        newProduct.minStock = minStock
        newProduct.memo = memo
        newProduct.inventoryQty = inventoryQty
        newProduct.expiryDate = expiryDate
        newProduct.createdAt = createdAt
        newProduct.updatedAt = updatedAt
        newProduct.unit = unit
        newProduct.category = category
        
        do{
            try repository.create(newProduct)
            try await readProducts()
        }catch{
            errorMessage = "Failed to create a product: \(error.localizedDescription)"
            print("Error has occured while creating a product: \(error)")
            throw error
        }
        
    }
    
    //TODO: get products with a category
    
    //update
    func updateProduct(id: UUID, name: String? = nil, stage: String? = nil, needsRestock: Bool? = nil, minStock: Int16? = nil, memo: String? = nil, inventoryQty: Int16? = nil, expiryDate: Date? = nil) async throws {
        
        // 제품 존재 확인
        guard let productToUpdate = products.first(where: {$0.id == id}) else {
            errorMessage = "Product Not Found"
            return
        }
        
        do {
            // 필드 업데이트
            if let name = name { productToUpdate.name = name }
            if let stage = stage { productToUpdate.stage = stage }
            if let minStock = minStock { productToUpdate.minStock = minStock }
            if let memo = memo { productToUpdate.memo = memo }
            if let inventoryQty = inventoryQty { productToUpdate.inventoryQty = inventoryQty }
            if let expiryDate = expiryDate { productToUpdate.expiryDate = expiryDate }
            productToUpdate.updatedAt = Date()
            
           
            if Int(productToUpdate.minStock) >= Int(productToUpdate.inventoryQty) {
                productToUpdate.needsRestock = true
            }else{
                productToUpdate.needsRestock = false
            }
            
          
            // Core Data 저장
            try repository.update(_product: productToUpdate)
            
            // 로컬 배열 업데이트 (Core Data 저장이 성공한 경우에만)
            if let index = self.products.firstIndex(where: {$0.id == id}) {
                self.products[index] = productToUpdate
            }
            
            // UI 업데이트 트리거
            self.objectWillChange.send()
            
            // 옵션: 전체 데이터 다시 로드 (필요한 경우에만)
            // try await readProducts()
        } catch {
            errorMessage = "Failed to update product: \(error.localizedDescription)"
            print("Error has occurred while updating product: \(error)")
            throw error
        }
    }
    
    
    
    
    //delete
    func deleteProduct(id: UUID) async throws{
        // delete selected product (with id)
        
        //find a product to delete
        guard let productToDelete = products.first(where: {$0.id == id}) else {
            errorMessage = "Product Not Found"
            return
        }
        
        do{
            try repository.delete(productToDelete)
            // UI 업데이트 트리거
            self.objectWillChange.send()
        }catch{
            errorMessage = "Failed to delete product: \(error.localizedDescription)"
            print("Error has occurred while deleting product: \(error)")
            throw error
        }
    }
}
