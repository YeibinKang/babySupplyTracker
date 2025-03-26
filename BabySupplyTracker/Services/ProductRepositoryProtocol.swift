//
//  ProductRepositoryProtocol.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-03-04.
//

import Foundation

protocol ProductRepositoryProtocol{
    func create(_ entity: Product) throws
    func fetchAll() async throws -> [Product]
    func fetchById(id: UUID) throws -> Product?
    func fetchByCategory(_ category: Category) async throws -> [Product]
    func save(_ entity: Product) throws
    func delete(_ entity: Product) throws
    func update(_product : Product) throws
    func createNewProduct() -> Product
}
