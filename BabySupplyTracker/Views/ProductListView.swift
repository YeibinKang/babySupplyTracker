//
//  ProductListView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-21.
//

import SwiftUI

struct ProductListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: ProductViewModel
    @EnvironmentObject private var categoryViewModel: CategoryViewModel
    @State private var showingAddView = false
    
    @State var categoriesLoaded = false
    
    
    var body: some View {
        
        //TODO: add sorting by category functionality 
        
            
        NavigationStack{
            VStack{
                
                Spacer().frame(height: 20)
                HStack{
                    Text("Sort by Category")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.secondary)
                                    
                                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.blue)

                    
                    Picker("Select Category", selection: $viewModel.selectedCategory){
                        Text("All").tag(nil as Category?)
                        ForEach(viewModel.categories, id:\.self){ category in
                            Text(category.name ?? "Unkown")
                                .tag(category as Category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: viewModel.selectedCategory){ newValue in
                        viewModel.updateCategory(newValue)
                        
                    }
                }
                
                
                List{
                    ForEach(viewModel.products, id: \.objectID){ product in
                        NavigationLink(destination: ProductDetailView(product: product)){
                            ProductRowView(product: product)
                        }

                    }
                
                    .onDelete{ IndexSet in
                        for index in IndexSet{
                            Task{
                                do{
                                    let productToDelete = viewModel.products[index]
                                    try await viewModel.deleteProduct(id: productToDelete.id!)
                                    viewModel.products.remove(at: index)
                                    
                                }catch{
                                    print("Error while deleting: \(error)")
                                }
                            }
                           
                        }
                    }
                    
                }
            }
            
           
            
            
            Button(action: {
                showingAddView = true
            }){
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add new product")
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showingAddView){
                ProductAddView(viewModel:viewModel, categoryViewModel: categoryViewModel, category: viewModel.products.first?.category)
            }
        }
        .onAppear{
            
            Task{
                do{
                    if !categoriesLoaded {
                        await viewModel.loadCategories()
                        categoriesLoaded = true
                    }
                    try await viewModel.readProducts()
                    try await viewModel.loadProductsByCategory()
                }
                catch{
                    print("Error occured while reading products in Product Repository: \(error)")
                
                }
            }
            
            
        }
        
        
    }
}

#Preview {
    ProductListView()
}
