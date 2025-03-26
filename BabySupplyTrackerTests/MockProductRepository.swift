//
//  MockProductRepository.swift
//  BabySupplyTrackerTests
//
//  Created by Yeibin Kang on 2025-03-04.
//

import Foundation
import XCTest
@testable import BabySupplyTracker
import CoreData

class MockProductRepository: XCTestCase{
    
    var sut: ProductRepository!
    var mockCoreDataStack: MockCoreDataStack!
    
    override func setUp(){
        super.setUp()
        mockCoreDataStack = MockCoreDataStack()
        sut = ProductRepository(context: mockCoreDataStack.viewContext)
    }
    
    override func tearDown() {
        sut = nil
        mockCoreDataStack = nil
        super.tearDown()
    }
    
    func testCreateProduct() throws{
        
        //Given
        let product = Product(context: mockCoreDataStack.viewContext)
        
        let categoryRepo = CategoryRepository(context: mockCoreDataStack.viewContext)
        let category = categoryRepo.createCategory(name: "test category", isDefault: false)
        
        product.id = UUID()
        product.name = "Kirkland Formula"
        product.stage = "1"
        product.inventoryQty = 3
        product.minStock = 2
        product.expiryDate = Date()
        product.category = category
        product.unit="can(s)"
        product.memo="test"
        product.createdAt = Date()
        
        // When/Then
        
        //no error while creating a product
        XCTAssertNoThrow(try sut.create(product), "No error while creating a product")
        
        //check if the product is saved
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id! as any CVarArg as CVarArg)
           
        
        let results = try mockCoreDataStack.viewContext.fetch(fetchRequest)
        XCTAssertEqual(results.count, 1, "The product should exist")
        XCTAssertEqual(results.first?.name, product.name, "The product name should match")
        
        
    }
    
    func testFetchAll() async throws {
        
        //Given
        let product1 = Product(context: mockCoreDataStack.viewContext)
        
        product1.id = UUID()
        product1.name = "Kirkland Formula"
        
        let product2 = Product(context: mockCoreDataStack.viewContext)
        product2.id = UUID()
        product2.name = "Baby wipes"
        
        let product3 = Product(context: mockCoreDataStack.viewContext)
        product3.id = UUID()
        product3.name = "apple sauce"
        
        try mockCoreDataStack.viewContext.save()
        
        //When, Then
        
        let results = try await sut.fetchAll()
        
        let productNameSet = Set(results.map { $0.name })
        XCTAssertTrue(productNameSet.contains("Kirkland Formula"))
        XCTAssertTrue(productNameSet.contains("Baby wipes"))
    }
    
    func testFetchById(){
        let product = Product(context: mockCoreDataStack.viewContext)
        product.id = UUID()
        product.name = "Body lotion"
        
        XCTAssertEqual(try! sut.fetchById(id: product.id!)?.name, "Body lotion")
    }
   

        
    
}
