//
//  BabySupplyTrackerApp.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-16.
//

import SwiftUI
import CoreData

@main
struct BabySupplyTrackerApp: App {

    @StateObject private var coreDataStack = CoreDataStack.shared
    @StateObject private var productViewModel: ProductViewModel
    @StateObject private var categoryViewModel: CategoryViewModel
    
    
    init(){
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let categoryRepository = CategoryRepository(context: context)
        _productViewModel = StateObject(wrappedValue: ProductViewModel(categoryRepository: categoryRepository))
        _categoryViewModel = StateObject(wrappedValue: CategoryViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.persistentContainer.viewContext)
                .environmentObject(productViewModel)
                .environmentObject(categoryViewModel)
        }
    }
}
