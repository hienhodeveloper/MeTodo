//
//  TimeFormatHelper.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

class TimeFormatHelper {
    static func timeAgoString(date: Date) -> String {
        let secondsInterval = Date().timeIntervalSince(date).rounded()
        if (secondsInterval < 10) {
            return "now"
        }
        if (secondsInterval < 60) {
            return String(Int(secondsInterval)) + " seconds ago"
        }
        let minutes = (secondsInterval / 60).rounded()
        if (minutes < 60) {
            return String(Int(minutes)) + " minutes ago"
        }
        let hours = (minutes / 60).rounded()
        if (hours < 24) {
            return String(Int(hours)) + " hours ago"
        }
        let days = (hours / 60).rounded()
        if (days < 30) {
            return String(Int(days)) + " days ago"
        }
        let months = (days / 30).rounded()
        if (months < 12) {
            return String(Int(months)) + " months ago"
        }
        let years = (months / 12).rounded()
        return String(Int(years)) + " years ago"
    }

    static func string(for date: Date?, format: String) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
}
