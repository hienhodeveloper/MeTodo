//
//  UserNotifications.swift
//  MeTodo
//
//  Created by Hien Ho on 6/3/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UserNotifications
import RealmSwift

class MeNotificationManager {
    static let shared = MeNotificationManager()
        
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {}
        }
    }
    
    func schedule(id: String, contentTitle: String, date: Date)-> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotification(id: id, contentTitle: contentTitle, date: date)
            default:
                break
            }
        }
    }
    
    func scheduleNotification(id: String, contentTitle: String, date: Date) -> Void {
            cancelNotifications(ids: [id])
            let content = UNMutableNotificationContent()
            content.title = contentTitle
            var mili = (date.timeIntervalSince1970 - Date().timeIntervalSince1970) / 1000
            if mili <= 0 {
                mili = 2
            }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: mili, repeats: false)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(id)")
            }
    }
    
    func cancelNotifications(ids: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: ids)
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
