//
//  File.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import FirebaseFirestore
import DeepDiff

struct CategoryTag: BaseModelProtocol {
    
    var id: String!
    var name: String!
    
    init(document: QueryDocumentSnapshot) {
        id = document.documentID
        let data = document.data()
        name = data["name"] as? String
    }
    
    init(name: String) {
        self.name = name
    }
    
    func generateParams() -> [String : Any] {
        ["name": name!]
    }
}

extension CategoryTag: DiffAware {
  var diffId: String {
    return id
  }

  static func compareContent(_ a: CategoryTag, _ b: CategoryTag) -> Bool {
    return a.name == b.name
  }
}
