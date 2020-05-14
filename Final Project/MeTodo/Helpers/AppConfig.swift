//
//  AppConfig.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

enum AppStringPlist: String {
    case GoogleServiceInfoFile = "Google Service File Name"
    case AppName = "CFBundleName"
    
    var text: String {
        guard let string = Bundle.main.object(forInfoDictionaryKey: self.rawValue) as? String else {
            fatalError("AppStringPlist not found for key: \(self.rawValue)")
        }
        print("AppStringPlist key = \(self) , text = \(string)")
        return string
    }
}
