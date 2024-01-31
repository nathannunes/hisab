//
//  hisabApp.swift
//  hisab
//
//  Created by Nathan Nunes on 1/18/24.
//

import SwiftUI
<<<<<<< Updated upstream

@main
struct hisabApp: App {
=======
import FirebaseCore

// AppDelegate class for additional setup, especially for Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Initialize Firebase
        FirebaseApp.configure()
        return true
    }
}

@main
struct hisabApp: App {
    // Using the AppDelegate for Firebase initialization
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // Persistence controller, assuming this is for Core Data
>>>>>>> Stashed changes
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // ContentView is the entry point of your SwiftUI app
            ContentView()
                // If using Core Data, provide the managed object context to the ContentView
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

