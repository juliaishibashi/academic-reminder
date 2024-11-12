//
//  academic_reminderApp.swift
//  academic-reminder
//
//  Created by Julia on 2024-08-23.
//

import SwiftUI
import SwiftData

@main
struct academic_reminderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Assignment.self)
        }
    }
}
