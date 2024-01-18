//
//  hisabApp.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI

@main
struct hisabApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
