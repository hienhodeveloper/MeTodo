//
//  AppDimension.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation
import Firebase

/**
 Base component in charge of logging events on the application.
 The goal of this class is to act as a proxy between the app and all the analytics services that are integrated.
 Broadcast every event to all of it associated services.
*/
class AnalyticsManager: AnalyticsService {

  static let shared = AnalyticsManager()

  public func identifyUser(with userId: String) {
     Analytics.setUserID(userId)
  }

  public func log(event: AnalyticsEvent) {
     Analytics.logEvent(event.name, parameters: event.parameters)
  }
}
