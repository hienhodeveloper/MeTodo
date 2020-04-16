//
//  AppImage.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

enum AppImageShape {
    case retangle
    case circle
}

class AppImageView: UIImageView {
    
    var shape: AppImageShape = .retangle {
        didSet {
            updateShape()
        }
    }
    
    var rectangleCornerRadius = CGFloat(0) {
        didSet {
            updateShape()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShape()
    }
    
    private func updateShape() {
        switch shape {
        case .retangle:
            layer.cornerRadius = rectangleCornerRadius
        case .circle:
            layer.cornerRadius = frame.size.height / 2
        }
        self.clipsToBounds = true
    }
}
