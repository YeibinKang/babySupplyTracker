//
//  CategoryIconManager.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-27.
//

import Foundation

struct CategoryIconManager{
    
    static func getIcon(for categoryName: String) -> String{
        switch categoryName {
        case "Hygiene Products": return "shower.fill"
        case "Feeding Supplies": return "waterbottle.fill"
        case "Diapers": return "toilet.fill"
        case "Baby Clothing": return "tshirt.fill"
        case "Sleep Products": return "bed.double.fill"
        case "Baby Food": return "fork.knife"
        case "Health Products": return "stethoscope"
        case "Toys": return "teddybear.fill"
        default:
            break
        }
        
        return ""
    }
    
    
   
    
}
