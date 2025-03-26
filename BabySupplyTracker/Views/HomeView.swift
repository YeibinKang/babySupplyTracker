//
//  HomeView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: ProductViewModel
    @State var productsToRestock: [Product] = []
    @State var isLoading = false
    @State private var greeting: String = ""
    @State private var userName: String = "Yeibin"
    
    var filteredProductsToRestock: [Product] {
        viewModel.products.filter { $0.needsRestock == true }
    }
    
    var body: some View {
        
        
        //show a list of need-to-restock items
        NavigationStack{
            VStack{
                
                HStack{
                    Text(greeting)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(userName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                if isLoading{
                    ProgressView().padding()
                }else if filteredProductsToRestock.isEmpty{
                    //restock is empty
                    VStack(spacing: 20){
                        Image(systemName: "checkmark.circle")
                            .font(.system(size:50))
                            .foregroundStyle(.green)
                        Text("All item slots are fully stocked")
                            .font(.headline)
                    }
                    .padding()
                }else{
                    
                    VStack(spacing: 20){
                        Image(systemName: "light.beacon.max.fill")
                            .font(.system(size:50))
                            .foregroundStyle(.orange)
                        Text("A few items need to be restocked")
                            .font(.headline)
                    }
                    .padding()
                    
                    List{
                        ForEach(filteredProductsToRestock, id: \.objectID){ product in
                            NavigationLink(destination: ProductDetailView(product: product)){
                                ProductRowView(product: product)
                            }
                            
                        }
                        
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.white)
                }
            }
            
            //TODO: additional information for inventory items
            
            
            
            
        }
        .onAppear{
            updateGreeting()
            loadData()
        }
    }
    
    private func loadData(){
        isLoading = true
        Task{
            do{
                try await viewModel.readProducts()
                isLoading =  false
            }catch{
                print("Error loading products in HomeView")
                isLoading = false
            }
        }
    }
    
    private func updateGreeting(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            greeting = "Good morning, "
            case 12..<17:
            greeting = "Good afternoon, "
            case 17..<21:
            greeting = "Good evening, "
        default:
            greeting = "Hello, "
        }
    }
}

//#Preview {
//    HomeView()
//}
