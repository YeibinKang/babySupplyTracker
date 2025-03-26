//
//  ProductUnit.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-27.
//

import Foundation

enum ProductUnit: String, CaseIterable, Identifiable{
    var id: String {self.rawValue}
    
    case each = "each"
    case piece = "piece(s)"
    case box = "box(es)"
    case bottle = "bottle(s)"
    case pack = "pack(s)"
    case can = "can(s)"
    case set = "set(s)"
    case bag = "bag(s)"
    case ml = "ml"
    case gram = "g"

}
