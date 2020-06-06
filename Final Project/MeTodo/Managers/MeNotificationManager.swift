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
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil {}
        }
    }
    
    func schedule(id: String, contentTitle: String, date: Date)-> Void {
        guard date > Date() else { return }
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
        content.sound = UNNotificationSound.default
        let triggerDaily = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {(error) in
            if let _ = error {
                AppNavigator.shared.currentViewController?.showMessage(title: R.string.localization.somethingWrong(), message:  R.string.localization.somethingWrongMessage())
            }
        })
    }
    
    func cancelNotifications(ids: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: ids)
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
}
