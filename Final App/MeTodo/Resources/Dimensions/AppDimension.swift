//
//  AppDimension.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

struct ScreenSize {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

struct CornerRadius {
    static let Medium = CGFloat(8)
    static let Regular = CGFloat(16)
    static let Large = CGFloat(40)
}

struct TextFieldHeight {
    static let Medium = CGFloat(60)
}

struct Margin {
    static let Tiny = CGFloat(8)
    static let Small = CGFloat(12)
    static let Medium = CGFloat(16)
    static let Normal = CGFloat(24)
    static let Regular = CGFloat(32)
    static let Hight = CGFloat(48)
    static let Large = CGFloat(64)
}

struct Spacing {
    static let Small = CGFloat(8)
    static let Medium = CGFloat(16)
    static let Hight = CGFloat(32)
    static let Large = CGFloat(64)
}

struct FontSize {
    static let Small = CGFloat(12)
    static let Medium = CGFloat(16)
    static let Regular = CGFloat(18)
    static let Higher = CGFloat(20)
    static let Header = CGFloat(36)
    static let Big = CGFloat(40)
}

struct AppScreenSize {
    static let screenSize = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
}

struct AppImageSize {
    static let Regular = CGSize(width: 24, height: 24)
    static let Large = CGSize(width: 56, height: 56)
}

struct IconButtonSize {
    static let Regular = CGSize(width: 24, height: 24)
    static let Hight = CGSize(width: 36, height: 36)
    static let Big = CGSize(width: 60, height: 60)
}
