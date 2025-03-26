//
//  CategoryViewModel.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-26.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    
    private var categoryRepository: CategoryRepository
    
    
    init(context: NSManagedObjectContext) {
        self.categoryRepository = CategoryRepository(context: context)
        
        
        Task{
            do{
                if categories.isEmpty{
                    try await categoryRepository.setupDefaultCategories()
                    try loadCategories()
                }
            }catch{
                print("Error has occured during category setup: \(error)")
            }
            
        }
        
        
    }
    
    func loadCategories() throws{
        do {
            
            //if no category?
            let fetchedCategories = try categoryRepository.fetchAll()
            
            self.categories = fetchedCategories
            
        } catch {
            
            print("Error has occurred while reading categories: \(error)")
            throw error
        }
        
    }
    
    //TODO: getCategoryById, getCategoryByName
    //    // 카테고리 ID로 찾기
    //        func getCategoryById(_ id: UUID?) -> Category? {
    //            guard let id = id else { return nil }
    //            return categories.first(where: { $0.id == id })
    //        }
    //
    //        // 카테고리 이름으로 찾기
    //        func getCategoryByName(_ name: String) -> Category? {
    //            return categories.first(where: { $0.name == name })
    //        }
}
