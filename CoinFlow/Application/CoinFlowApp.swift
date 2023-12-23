//
//  CoinFlowApp.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 18.12.2023.
//

import SwiftUI

@main
struct CoinFlowApp: App {
    let context = CoreDataController.shared.context
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                // Start view
            }
            .environment(\.managedObjectContext, context)
        }
    }
}
