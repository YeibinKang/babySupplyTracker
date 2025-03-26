//
//  ProductRowView.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-21.
//

import SwiftUI

struct ProductRowView: View {
    
    @ObservedObject var product: Product
   
    var body: some View {

        var categoryName = product.category?.name
        
        HStack{
            //TODO: add category icon
            
            Image(systemName: CategoryIconManager.getIcon(for: categoryName ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(String(product.inventoryQty))
            Text(product.unit ?? "")
            Text(" of ")
            Text(product.name ?? "")
            
          
        }
        .background(product.needsRestock ? Color.red : Color.clear)
        
        
    }
}

//#Preview {
//    ProductRowView(product: <#T##Product#>)
//}
