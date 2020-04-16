//
//  AppDimension.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation
/**
 Protocol that defines the minimum API that an AnalyticsService should expose.
 The AnalyticsService is in charge of handling event logging for a specific analytics platform.
*/
protocol AnalyticsService {
    
  /// Identifies the user with a unique ID
  func identifyUser(with userId: String)

  /// Logs an event with it's associated metadata
  func log(event: AnalyticsEvent)
}
