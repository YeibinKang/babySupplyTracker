//
//  BabySupplyTrackerApp.swift
//  BabySupplyTracker
//
//  Created by Yeibin Kang on 2025-02-16.
//

import SwiftUI

@main
struct BabySupplyTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
