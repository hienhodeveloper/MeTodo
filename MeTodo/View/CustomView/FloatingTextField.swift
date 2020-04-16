//
//  FloatingTextField.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/15/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

class FloatingTextField: AppView {

    private let titleLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: FontSize.Medium, weight: .medium)
        $0.text = "Date"
        $0.textColor = R.color.titleTextFieldColor()!
    }
    
    let textField = Init(value: AppTextField() ) {
        $0.font = .systemFont(ofSize: FontSize.Higher, weight: .medium)
        $0.text = "hello world"
        $0.tintColor = .systemGray4
        $0.bottomLineWidth = 2.0
    }
    
    private let rightButton = Init(value: AppButton() ) {
        $0.tintColor = R.color.dimPurpleColor()!
        $0.setImage(UIImage(systemName: "book"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    var rightButtonSize = CGSize(width: 26, height: 26)
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    override func setupView() {
        super.setupView()
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(rightButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-6)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        textField.padding = .init(top: 0, left: 2, bottom: 10, right: rightButtonSize.width + 8)
        
        rightButton.snp.makeConstraints {
            $0.right.equalTo(textField.snp.right)
            $0.size.equalTo(rightButtonSize)
            $0.top.equalTo(textField)
        }
    }

}
