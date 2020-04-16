//
//  FirebaseService.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseService {
    func signIn(email: String, password: String, success: @escaping () -> Void, failure: @escaping (AppError) -> Void )
    func signUp(email: String, password: String, success: @escaping () -> Void, failure: @escaping (AppError) -> Void )
}
