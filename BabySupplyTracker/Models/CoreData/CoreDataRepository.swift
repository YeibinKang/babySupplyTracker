//
//  CoreDataRepository.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-18.
//

import Foundation
import CoreData

protocol CoreDataRepository {
    associatedtype Entity: NSManagedObject
    
    init(context: NSManagedObjectContext)
    
    func create(_ entity: Entity) throws
    func fetchAll() async throws -> [Entity] 
    func fetchById(id: UUID) throws -> Entity? 
    func save(_ entity: Entity) throws
    func delete(_ entity: Entity) throws
}
