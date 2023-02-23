import Foundation
import UserNotifications

final class LocalPushNotificationManager: PushNotificationManager {
    
    // MARK: - Private Methods
    private let center = UNUserNotificationCenter.current()
    
    // MARK: - PushNotificationManager
    func requestAuthorication() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            guard granted else {
                print("Разрешение не получено")
                return
            }
        }
    }
    
    func registerNotification() {
        center.requestAuthorization { [weak self] granted, error in
            guard granted else {
                print("Разрешение не получено")
                return
            }
            
            self?.registerComeBackNotification()
        }
    }
}

// MARK: - LocalPushNotificationManager
private extension LocalPushNotificationManager {
    func registerComeBackNotification() {
        let content = makeNotificationContent()
        let trigger = makeIntervalNotificatioTrigger()
        sendNotificatioRequest(content: content, trigger: trigger)
    }
    
    func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Плиз кам бэк в приложение"
        content.subtitle = "Прошу молю вернитесь"
        content.badge = 1
        return content
    }
    
    func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(
            timeInterval: 60 * 30,
            repeats: false
        )
    }
    func sendNotificatioRequest( content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(
            identifier: "alaram",
            content: content,
            trigger: trigger
        )
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
