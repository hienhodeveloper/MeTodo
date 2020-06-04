//
//  Task.swift
//  Todo
//
//  Created by Jake Shelley on 11/27/17.
//  Copyright © 2017 Jake Shelley. All rights reserved.
//

import Foundation
import RealmSwift

enum TaskLevel: String , CaseIterable {
    case low    = "low"
    case medium = "medium"
    case high  = "hight"
    
    var text: String {
        switch self {
        case .low:
            return R.string.localization.low()
        case .medium:
            return R.string.localization.medium()
        case .high:
            return R.string.localization.hight()
        }
    }
}

class Task: Object {
    @objc dynamic var text = ""
    @objc dynamic var dueDate = Date(timeIntervalSince1970: 1)
    @objc dynamic var note = ""
    @objc dynamic var level = TaskLevel.low.rawValue
    
    var taskLevel: TaskLevel {
        return TaskLevel(rawValue: level)!
    }
}
