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
    var buttonStyle: AppButtonType = .onlyTitle {
        didSet {
            switch buttonStyle {
            case .onlyIcon:
                titleLabel?.text = nil
                imageView?.snp.remakeConstraints {
                    $0.edges.equalToSuperview()
                }
            case .iconWithTitle:
                imageView?.snp.remakeConstraints { make in
                    make.size.equalTo(IconButtonSize.Regular)
                    make.right.equalTo(titleLabel!.snp.left).offset(-spaceBetweenIconAndTitle)
                }
            case .onlyTitle:
                imageView?.image = nil
            }
        }
    }
    
    var spaceBetweenIconAndTitle = Spacing.Small
}
