//
//  AppNavigator.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/4/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation
import Firebase

class AppNavigator: BaseNavigator {
  static let shared = AppNavigator()

  init() {
    super.init(with: HomeRoutes.home)
  }

  required init(with route: Route) {
    super.init(with: route)
  }
}
