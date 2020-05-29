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
//    let isHaveCurrentUser = Auth.auth().currentUser != nil
//    let initialRoute: Route = isHaveCurrentUser ?
//      HomeRoutes.home : OnboardingRoutes.onboard
    let initialRoute = HomeRoutes.home
    super.init(with: initialRoute)
  }

  required init(with route: Route) {
    super.init(with: route)
  }
}
