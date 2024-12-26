import SwiftUI
import UserNotifications
import SwiftData

struct NotificationManager {
    
    @Environment(\.modelContext) private var context
    @Query private var assignment_quiery: [Assignment]
    @Query private var reminder_quiery: [Reminder]
    
    func scheduleNotification(for assignment: Assignment, with reminder: Reminder) {
        // Step 1: Parse the assignment date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let deadlineDate = dateFormatter.date(from: assignment.date) else {
            print("Invalid date format")
            return
        }
        
        // Step 2: Convert remindValue to Int
        guard let remindValueInt = Int(reminder.remindValue) else {
            print("Invalid remindValue format")
            return
        }
        
        // Step 3: Calculate the notification date
        var notificationDate = deadlineDate
        switch reminder.selectedOption {
        case "Minutes":
            notificationDate = Calendar.current.date(byAdding: .minute, value: -remindValueInt, to: deadlineDate) ?? deadlineDate
        case "Hours":
            notificationDate = Calendar.current.date(byAdding: .hour, value: -remindValueInt, to: deadlineDate) ?? deadlineDate
        case "Days":
            notificationDate = Calendar.current.date(byAdding: .day, value: -remindValueInt, to: deadlineDate) ?? deadlineDate
        case "Weeks":
            notificationDate = Calendar.current.date(byAdding: .weekOfYear, value: -remindValueInt, to: deadlineDate) ?? deadlineDate
        default:
            print("Invalid reminder option")
            return
        }
        
        // Step 4: Schedule the local notification
        let content = UNMutableNotificationContent()
        content.title = "Assignment Reminder"
        content.body = "\(assignment.title) is due on \(assignment.date)."
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(notificationDate)")
            }
        }
    }
    func scheduleNotificationsForAllAssignments() {
        // Step 5: Loop through assignments and reminders to schedule notifications
        for assignment in assignment_quiery {
            for reminder in assignment.children {
                scheduleNotification(for: assignment, with: reminder)
            }
        }
    }
}

//struct UserData{
//    let title: String?
//    let body: String?
//    let date: Date?
//    let time: Date?
//}
//
//struct NoticicationManager{
//
//    static func scheduleNotification(userData: UserData){
//
//        let content = UNMutableNotificationContent()
//        content.title = userData.title ?? ""
//        content.body = userData.body ?? ""
//
//        //date components
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
//
//        if let reminderTime = userData.time{
//            let reminderTimeDateComponents = reminderTime.dateComponents
//            dateComponents.hour = reminderTimeDateComponents.hour
//            dateComponents.minute = reminderTimeDateComponents.minute
//        }
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//    }
//
//}


//func sendLocalPush(){
//    //1. notification content
//    let content = UNMutableNotificationContent()
//    content.title = "local notification"
//    content.subtitle = "hello from local"
//    content.sound = .default
//    
//    //2. set trigger
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//    
//    //3. make req with content and teigger
//    let request = UNNotificationRequest(identifier: "alerm_id", content: content, trigger: trigger)
//    
//    //4. add requet
//    let center = UNUserNotificationCenter.current()
//    center.add(request) { error in
//        if let error {
//            print(error.localizedDescription)
//        }
//    }
//}
