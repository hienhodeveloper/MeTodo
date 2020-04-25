//
//  Ticket.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation
import FirebaseFirestore
import DeepDiff

struct Ticket: BaseModelProtocol {
    func generateParams() -> [String : Any] {
        [
            "name": name!,
            "startingTime": startingTime!,
            "workingTime": workingTime!,
            "category": catergory!,
            "isDone": isDone!,
            "remindMe": remindMe!
        ]
    }
    
    var id: String!
    var name: String!
    var startingTime: Timestamp!
    var workingTime: Int!
    var catergory: String!
    var isDone: Bool!
    var remindMe: Bool!
    
    init(name: String, category: String, startingTime: Timestamp, workingTime: Int, isDone: Bool, remindMe: Bool) {
        self.name = name
        self.catergory = category
        self.startingTime = startingTime
        self.workingTime = workingTime
        self.isDone = isDone
        self.remindMe = remindMe
    }
    
    init(document: QueryDocumentSnapshot) {
        id = document.documentID
        let data = document.data()
        name = data["name"] as? String
        startingTime =  data["startingTime"] as? Timestamp
        workingTime = data["workingTime"] as? Int
        catergory = data["category"] as? String
        isDone = data["isDone"] as? Bool
        remindMe = data["remindMe"] as? Bool
    }
    
    func getDateTime() -> String {
        var startTime = "00:00"
        startTime = TimeFormatHelper.string(for: startingTime.dateValue(), format: "MMM d, HH:mm")
        var workTime = " -"
        if let workingTime = workingTime {
            let dateTMP = startingTime.dateValue()
            workTime = " - " + TimeFormatHelper.string(for: dateTMP.addingTimeInterval(TimeInterval(workingTime)), format: "HH:mm")
        }
        return "\(startTime)\(workTime)"
    }
}

extension Ticket: DiffAware {
  var diffId: String {
    return id
  }

  static func compareContent(_ a: Ticket, _ b: Ticket) -> Bool {
    return a.name == b.name && a.catergory == b.catergory
  }
}
