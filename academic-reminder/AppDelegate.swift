import UIKit
import UserNotifications

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application (_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // この関数を実装することで、フォアグラウンド時にも通知が表示されるようになる。
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("フォアグラウンド時に通知されました")
        completionHandler([.sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("通知がタップされました")
        completionHandler()
    }
}
