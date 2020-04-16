//
//  FirebaseManager.swift
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
class FirebaseManager: FirebaseService {
    func signUp(email: String, password: String, success: @escaping () -> Void, failure: @escaping (AppError) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                success()
            }
            if let error = error {
                failure(.init(from: error as NSError))
            }
        }
    }
    
    func signIn(email: String, password: String,success: @escaping () -> Void, failure: @escaping (AppError) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                success()
            }
            if let error = error {
                failure(.init(from: error as NSError))
            }
        }
    }
    
    static let shared = FirebaseManager()
    
    public func setup() {
        let googleServicesPath = AppStringPlist.GoogleServiceInfoFile.text
        guard
            let filePath = Bundle.main.path(forResource: googleServicesPath, ofType: "plist"),
            let firebaseOptions = FirebaseOptions(contentsOfFile: filePath) else {
                fatalError("Failed to initialize firebase options, please check your configuration settings")
        }
        FirebaseApp.configure(options: firebaseOptions)
    }
    
    
    
}
