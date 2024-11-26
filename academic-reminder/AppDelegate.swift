//import UIKit
//import UserNotifications
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    static var shared: AppDelegate? {
//            return UIApplication.shared.delegate as? AppDelegate
//    }
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("Notification allowed")
//            } else {
//                print("Notification denied")
//            }
//        }
//        return true
//    }
//    
//    func scheduleNotification(for assignment: Assignment, with reminder: Reminder){
//        
//        print("Debug: scheduleNotification called")
//        print("Debug: Assignment Title: \(assignment.title)")
//        print("Debug: Reminder Value: \(reminder.remindValue)")
//        
//        let content = UNMutableNotificationContent()
//        content.title = assignment.title
//        content.body = "the deadline is approaching in \(reminder.remindValue)"
//        content.sound = .default
//        
//        print("Debug: Notification Content Title: \(content.title)")
//        print("Debug: Notification Content Body: \(content.body)")
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request){ error in
//            if let error = error {
//                print("Failed to add notification: \(error)")
//            } else {
//                print("Notification added successfully.")
//            }
//        }
//    }
//}// class
