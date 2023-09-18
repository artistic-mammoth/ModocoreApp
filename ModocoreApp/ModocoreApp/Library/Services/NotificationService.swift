//
//  NotificationService.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 02.08.2023.
//

import UserNotifications

final class NotificationService: NSObject {
    // MARK: - Singleton implementation
    static let shared = NotificationService()
    
    // MARK: - Private properties
    private let identifiers: [String] = (1...10).map { "session-\($0)" }
    private let notificationCenter = {
        UNUserNotificationCenter.current()
    }()
    
    // MARK: - Init
    private override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    // MARK: - Deinit
    deinit {
        removeTimerNotifications()
    }
    
    // MARK: - Public methods
    func checkForNotificationPremission() {
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                self.notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { didAllow, error in
                    if error != nil { print(error?.localizedDescription ?? "error in checkForNotificationPremission") }
                }
            }
        }
    }
    
    func updateNotificationForTimer(setup: SessionSetup, currentTime: Int, currentIntervalIndex: Int) {
        removeTimerNotifications()
        
        var allTimes: Int = currentTime + 1

        for (index, interval) in setup.enumerated() {
            guard index >= currentIntervalIndex else { continue }
            
            let id = "session-\(index + 1)"

            let title = "\(interval.type == .focus ? "Focus" : "Rest") is done"
            let body = "Time to \(interval.type == .focus ? "rest" : "focus")"

            let lastTitle = "All done"
            let lastBody = "Set new pomodoros"

            let content = UNMutableNotificationContent()
            content.title = index == setup.endIndex-1 ? lastTitle : title
            content.body = index == setup.endIndex-1 ? lastBody : body
            content.sound = .default
            
            allTimes += index == currentIntervalIndex ? 0 : (interval.seconds + 1)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(allTimes), repeats: false)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

            notificationCenter.add(request, withCompletionHandler: { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error notification")
                }
            })
        }
    }
    
    func removeTimerNotifications() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
}
