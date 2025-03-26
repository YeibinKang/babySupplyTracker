//
//  ProductEditView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-24.
//
import SwiftUI

struct ProductEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject private var viewModel: ProductViewModel
    
    private let productID: UUID
    
    @State private var inventoryQty: Int16
    @State private var needsRestock: Bool
    @State private var minStock: Int16
    @State private var memo: String
    @State private var expiryDate: Date
    @State private var name: String
    
    init(product: Product) {
        self.productID = product.id!
        
        // 모든 필드를 @State로 초기화
        _inventoryQty = State(initialValue: product.inventoryQty)
        _needsRestock = State(initialValue: product.needsRestock)
        _minStock = State(initialValue: product.minStock)
        _memo = State(initialValue: product.memo ?? "")
        _expiryDate = State(initialValue: product.expiryDate ?? Date())
        _name = State(initialValue: product.name ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Product Information")) {
                    Stepper("Inventory QTY \(inventoryQty)", value: $inventoryQty, in: 0...100)
                    Stepper("Minimum Stock QTY \(minStock)", value: $minStock, in: 0...100)
                    LabeledContent("Memo"){
                        TextEditor(text: $memo)
                            .frame(height:100)
                    }

                }
            }
            .toolbar {
               
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            do {
                                
                                try await viewModel.updateProduct(
                                    id: productID,
                                    needsRestock: needsRestock,
                                    minStock: minStock,
                                    memo: memo,
                                    inventoryQty: Int16(inventoryQty),
                                    expiryDate: expiryDate
                                )
                                await MainActor.run {
                                    dismiss()
                                }
                            } catch {
                                print("Error updating product: \(error)")
                          
                            }
                        }
                    }
                }
            }
        }
    }
}
//import SwiftUI
//
//struct ProductEditView: View {
//    
//    
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.managedObjectContext) var context
//    
//    @EnvironmentObject private var viewModel: ProductViewModel
//    @ObservedObject private var editingProduct: Product
//    
//    private let productID: UUID
//    @State private var name:String
//    @State private var inventoryQty: Int
//    
//    
//    init(product: Product){
//        self.productID = product.id!
//        self.editingProduct = product
//        _inventoryQty = .init(initialValue: Int(product.inventoryQty))
//        _name = State(initialValue: product.name ?? "")
//    }
//    
//    var body: some View {
//        
//        NavigationStack{
//            Form {
//      
//                    Section(header: Text("Product Information")) {
//                        Stepper("Inventory QTY \(inventoryQty)", value: $editingProduct.inventoryQty, in: 0...100)
//                        LabeledContent("Name") {
//                            TextField("Product Name", text: $name)
//                        }
//                        
//                    
//                        
//                    }
//
//            }
//            .toolbar{
//                ToolbarItem(placement: .confirmationAction){
//                    Button("Save"){
//                        
//                        //list update?
//                        Task{
//                            do{
//                                
//                                try await viewModel.updateProduct(
//                                               id: productID,
//                                               name: name,
//                                               stage: editingProduct.stage,
//                                               needsRestock: editingProduct.needsRestock,
//                                               minStock: editingProduct.minStock,
//                                               memo: editingProduct.memo,
//                                               inventoryQty: editingProduct.inventoryQty,
//                                               expiryDate: editingProduct.expiryDate
//                                           )
//                                await MainActor.run{
//                                    dismiss()
//                                }
//                            }catch{
//                                print("Error updating product: \(error)")
//                            }
//
//                        }
//                        
//
//                    }
//                }
//            }
//        }
//        
//        
//        
//    }
//    
//    //#Preview {
//    //    ProductEditView(product:Product)
//    //}
//}
