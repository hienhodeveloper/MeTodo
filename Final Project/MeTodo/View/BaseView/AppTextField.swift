//
//  AppTextField.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift

class AppTextField: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override var tintColor: UIColor! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var bottomLineWidth: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var isDisableAllAction = false

    override func draw(_ rect: CGRect) {

        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)

        let path = UIBezierPath()

        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = bottomLineWidth
    
        tintColor.setStroke()
        
        path.stroke()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return !isDisableAllAction
    }
}
