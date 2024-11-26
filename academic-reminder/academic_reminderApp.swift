////
////  academic_reminderApp.swift
////  academic-reminder
////
////  Created by Julia on 2024-08-23.
////
//import SwiftUI
//import UserNotifications
//import SwiftData
//
//@main
//struct academic_reminderApp: App {
//
//    init() {
//        requestNotificationPermission()
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .modelContainer(for: Assignment.self)
//        }
//    }
//    
//    private func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("notification allowed")
//            } else {
//                print("notification dened")
//            }
//        }
//    }
//}

import SwiftUI
import SwiftData
import UserNotifications

@main
struct academic_reminderApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Assignment.self)
        }
    }
}
