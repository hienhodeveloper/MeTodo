//
//  Object.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

extension NSObject {
    static var name: String {
        return String(describing: self)
    }
}
