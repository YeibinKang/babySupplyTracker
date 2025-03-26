//
//  DatabaseService.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-17.
//

import Foundation
import CoreData

class DatabaseService{
    private let coreDataStack = CoreDataStack.shared
    static let shared = DatabaseService()   //다른 클래스에서 접근 가능
    private var context: NSManagedObjectContext{
        return coreDataStack.persistentContainer.viewContext
    }
    private init(){}
    
    //func createProduct
    
}
