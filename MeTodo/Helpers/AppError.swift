//
//  AppError.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

struct AppError: Error, Equatable {
    
    let domain = Bundle.main.bundleIdentifier!
    var errorCode: Int!
    var appErrorDescription: String {
        switch ErrorCode(rawValue: errorCode) {
        case .invalidEmail:
            return "Email has been wrong"
        case .userNotFound:
            return "User not found"
        case .userEmailTaken:
            return "Email has been used"
        case .connectionFailed:
            return "Connection Failed"
        case .none:
            fatalError("Unidentify Error")
        }
    }
    
    var rootDesciption: String!

    init(from error: NSError) {
        errorCode = error.code
        rootDesciption = error.description
    }
}

enum ErrorCode: Int {
    case invalidEmail = 125
    case userNotFound = 205
    case userEmailTaken = 203
    case connectionFailed = 100
}
