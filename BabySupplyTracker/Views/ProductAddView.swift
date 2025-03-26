//
//  ProductAddView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-21.
//

import Foundation
import SwiftUI

public struct ProductAddView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var viewModel: ProductViewModel
    @ObservedObject var categoryViewModel: CategoryViewModel
    
    @State private var name:String = ""
    @State private var stage:String = ""
    @State private var unit:String = ""
    @State private var needsRestock: Bool = false
    @State private var minStock: Int16 = 0
    @State private var memo: String = ""
    @State private var inventoryQty:Int16 = 0
    @State private var expiryDate:Date = Date()
    @State private var createdAt:Date = Date()
    @State private var updatedAt:Date = Date()
    @State private var selectedCategory:Category?
    
    @State private var isCreated: Bool = false
    @State private var selectedUnit: ProductUnit = .each
    
    init(viewModel: ProductViewModel, categoryViewModel: CategoryViewModel, category: Category? = nil) {
        self.viewModel = viewModel
        self.categoryViewModel = categoryViewModel
        self._selectedCategory = State(initialValue: category)
        
    }
    
    
    public var body: some View {
        
        VStack{
            
            HStack{
                
                Spacer()
                Button("Cancel"){
                    dismiss()
                }
                .padding()
            }
            
            
            NavigationStack{
                Form{
                    Section(header: Text("Product Information")){
                        LabeledContent("Name") {
                            TextField("", text:$name)
                        }
                        LabeledContent("Stage") {
                            TextField("", text:$stage)
                        }
                        
                        Stepper("Inventory QTY \(inventoryQty)", value: $inventoryQty, in: 0...100)

                        if !viewModel.categories.isEmpty {
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(viewModel.categories, id: \.self) { category in
                                            Text(category.name ?? "None")
                                                .tag(category as Category?)
                                        }
                            }
                           
                        } else {
                            Text("No category")
                        }
                        

                        Picker("Unit", selection: $unit){
                            ForEach(ProductUnit.allCases){ unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        
                        
                
                        
                        
                        LabeledContent("Expiry Date"){
                            DatePicker("", selection: $expiryDate, displayedComponents: [.date])
                        }
                        LabeledContent("Created Date"){
                            DatePicker("", selection: $createdAt, displayedComponents: [.date])
                        }
                        
                       
                            
                        Stepper("Minimum Inventory QTY \(minStock)", value: $minStock, in: 0...100)

                        LabeledContent("Memo"){
                            TextEditor(text: $memo)
                                .frame(height:100)
                        }
                        
                        
                        
                        
                    }
                    
                    
                }
                
            }
            
            Button(action:{
                
                
                Task {
                    do{
                        try await viewModel.createProduct(name: name, stage: stage, needsRestock: needsRestock, minStock: minStock, memo: memo, inventoryQty: inventoryQty, expiryDate: expiryDate, createdAt: createdAt, updatedAt: updatedAt, unit: unit, category: (selectedCategory ?? categoryViewModel.categories.first)!)
                        
                        name = ""
                        stage = ""
                        needsRestock = false
                        minStock = 0
                        memo = ""
                        inventoryQty = 0
                        expiryDate = Date()
                        createdAt = Date()
                        updatedAt = Date()
                        unit = ""
                        
                        
                        try await viewModel.readProducts()
                    }catch{
                        print("Error creating product: \(error)")
                    }
                    
                }
                
                dismiss()
            }){
                Text("Add")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            
            
        }
        
        
        
        
    }
}
