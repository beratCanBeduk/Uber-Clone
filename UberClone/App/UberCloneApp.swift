//
//  UberCloneApp.swift
//  UberClone
//
//  Created by berat can beduk on 7.12.2022.
//

import SwiftUI

@main
struct UberCloneApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var locationViewModel  = LocationSearchViewModel()
    var body: some Scene {
        
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(locationViewModel)
        }
    }
}
