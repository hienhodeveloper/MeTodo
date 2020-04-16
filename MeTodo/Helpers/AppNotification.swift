//
//  AppNotification.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

extension Notification.Name {
    static var SignInSuccess: Notification.Name {
          return .init(rawValue: "UserLogin.success") }
    static var SignUpSuccess: Notification.Name {
          return .init(rawValue: "UserSignUp.success") }
}
