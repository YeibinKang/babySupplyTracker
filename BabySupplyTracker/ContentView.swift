//
//  ContentView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab){
            
            HomeView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                    
                }
                .tag(0)
            
            ProductListView()
                .tabItem{
                    Image(systemName: "archivebox.fill")
                    Text("Inventory")
                }
                .tag(1)
            
//            ProfileView()
//                .tabItem{
//                    Image(systemName: "person.fill")
//                    Text("Profile")
//                }
            
            
            
        }
    }
}



//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
