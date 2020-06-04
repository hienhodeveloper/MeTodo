//
//  UserNotifications.swift
//  MeTodo
//
//  Created by Hien Ho on 6/3/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UserNotifications

struct MeNotification {
    var id: String
    var title: String
    var date: Date
}

class MeNotificationManager {
    static let shared = MeNotificationManager()
    
    var notifications = [MeNotification]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    self.scheduleNotifications()
                    // We have permission!
                }
        }
    }
    
    func addNotification(title: String, date: Date) -> Void {
        notifications.append(MeNotification(id: UUID().uuidString, title: title, date: date))
    }
    
    func schedule() -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notification.date.timeIntervalSince1970, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
    }
    
    func cancelNotifications(ids: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: ids)
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
