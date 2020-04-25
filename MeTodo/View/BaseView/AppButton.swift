//
//  AppButton.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

enum AppButtonType {
    case onlyIcon
    case iconWithTitle
    case onlyTitle
}
class AppButton: UIButton {
    var iconSize: CGSize = IconButtonSize.Regular {
        didSet {
            imageView?.snp.remakeConstraints {
                $0.size.equalTo(iconSize)
            }
        }
    }
}
