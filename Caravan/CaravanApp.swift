//
//  CaravanApp.swift
//  Caravan
//
//  Created by Bowen Tan on 10/22/21.
//

import SwiftUI
import Firebase

@main
struct CaravanApp: App {
    init() {
        FirebaseApp.configure()
     //  https://betterprogramming.pub/how-to-use-firebase-in-swiftuis-new-application-lifecycle-c77a8a306d63
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
