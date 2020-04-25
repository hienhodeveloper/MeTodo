//
//  FloatingTextField.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/15/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

protocol FloatingTextFieldDelegate: class {
    func floatingTextField(_ view: FloatingTextField, didTapRightButton button: AppButton)
}

class FloatingTextField: AppView {
    weak var delegate: FloatingTextFieldDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    var isEnableInput: Bool = true {
        didSet {
            textField.isUserInteractionEnabled = isEnableInput
        }
    }
    
    var rightIcon: UIImage? {
        didSet {
            rightButton.setImage(rightIcon, for: .normal)
        }
    }
    
    var isHiddenRightButton: Bool = false {
        didSet {
            if isHiddenRightButton {
                textField.padding = .init(top: 0, left: 2, bottom: 10, right: 2)
                rightButton.isHidden = true
            } else {
                textField.padding = .init(top: 0, left: 2, bottom: 10, right: rightButtonSize.width + 8)
                rightButton.isHidden = false
            }
        }
    }
    
    
    private let titleLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: FontSize.Medium, weight: .regular)
        $0.text = "Title"
        $0.textColor = R.color.titleTextFieldColor()!
    }
    
    let textField = Init(value: AppTextField() ) {
        $0.font = .systemFont(ofSize: FontSize.Higher, weight: .regular)
        $0.textColor = .black
        $0.tintColor = .systemGray4
        $0.bottomLineWidth = 2.0
    }
    
    private let rightButton = Init(value: AppButton() ) {
        $0.tintColor = R.color.dimPurpleColor()!
        $0.setImage(UIImage(systemName: "book"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(FloatingTextField.didTapRightButton(sender:)), for: .touchUpInside)
        $0.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    var rightButtonSize = CGSize(width: 26, height: 26)
    
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
    
    @objc func didTapRightButton(sender: AppButton) {
        delegate?.floatingTextField(self, didTapRightButton: sender)
    }
}
