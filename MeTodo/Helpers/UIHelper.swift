//
//  UIHelper.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/4/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

/// For Initial an object  quickly with your setting
/// Ex: let titleLabel = Init(value: UILabel()) {
///     $0.text = "hell world"
///     $0.textColor = .black
/// }
/// - Parameters:
///   - value: any object you want to create
///   - block: closure for setting your object
/// - Returns: your object
func Init<Type>(value: Type, block: (_ object: Type) -> Void) -> Type {
    block(value)
    return value
}
