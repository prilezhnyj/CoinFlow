//
//  CoinFlowApp.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 18.12.2023.
//

import SwiftUI

@main
struct CoinFlowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
