//
//  ProductDetailView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-21.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject private var viewModel: ProductViewModel
        private let product: Product
        @State private var showingEditView = false

        
        init(product: Product) {
            self.product = product
        }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {

                        LabeledContent {
                            Text(product.name ?? "N/A")
                        } label: {
                            Text("Name")
                        }
                        LabeledContent {
                            Text(product.stage ?? "N/A")
                        } label: {
                            Text("Stage")
                        }
                        LabeledContent {
                            if product.inventoryQty == 0 {
                                Text("N/A")
                            } else {
                                Text("\(product.inventoryQty)")
                            }
                        } label: {
                            Text("Inventory QTY")
                        }
                        LabeledContent {
                            Text(product.unit ?? "N/A")
                        } label: {
                            Text("Unit")
                        }

                        
                        LabeledContent{
                            Text(product.category?.name ?? "None")
                        } label:{
                            Text("Category")
                        }
                        
                        LabeledContent("Expiry Date") {
                            if let date = product.expiryDate {
                                Text(date, style: .date)
                            } else {
                                Text("N/A")
                            }
                        }
                        LabeledContent("Created Date") {
                            if let date = product.createdAt {
                                Text(date, style: .date)
                            } else {
                                Text("N/A")
                            }
                        }
                        LabeledContent("Minimum Stock QTY") {
                            if product.minStock == 0 {
                                Text("N/A")
                            } else {
                                Text("\(product.minStock)")
                            }
                        }
                        
                        if product.needsRestock {
                            let productName = product.name ?? "Baby product"
                                let productStage = product.stage ?? ""
                            
                            let searchQuery = "\(productName) \(productStage) baby product"
                            //show a button
                            Button {
                                // 제품 이름을 URL 인코딩
                                if let encodedName = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                   let url = URL(string: "https://www.google.com/search?tbm=shop&q=\(encodedName)") {
                                    // Safari로 URL 열기
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "cart")
                                    Text("Buy")
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                        
                    } header: {
                        Text("Product Information")
                    }
                    
                    if let memo = product.memo, !memo.isEmpty {
                        Section(header: Text("Memo")) {
                            TextEditor(text: .constant(memo))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 8)
                                .disabled(true)
                                .frame(height: 100)
                        }
                    }
                }
                
                Button(action: {
                    showingEditView = true
                }) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            .sheet(isPresented: $showingEditView) {
                ProductEditView(product: product)
                    .onDisappear {
                        Task {
                            try? await viewModel.readProducts()
                        }
                    }
            }
        }
    }
        
        
         
    }
    
    

//#Preview {
//    ProductDetailView(product: Product(name:"n"))
//}
