//
//  OnboardHeaderView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit

protocol OnboardHeaderViewDelegate: class {
    func onboardHeaderView(_ view: OnboardHeaderView, didTapRightButton button: AppButton)
}

class OnboardHeaderView: AppStackView {
    private let headerLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    private let rightButton = Init(value: AppButton()) {
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    weak var delegate: OnboardHeaderViewDelegate?
    
    @IBInspectable var headerText: String! {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var rightText: String? {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var headerTextColor: UIColor = .black {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var rightTextColor: UIColor = .black {
        didSet {
            setupView()
        }
    }
    
    @objc func didTapRightButton(sender: AppButton) {
        delegate?.onboardHeaderView(self, didTapRightButton: sender)
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: Private Methods
    
    private func setupView() {
        alignment = .center
        axis = .horizontal
        distribution = .equalSpacing
        for views in arrangedSubviews {
            views.removeFromSuperview()
        }
        headerLabel.textColor = headerTextColor
        headerLabel.text = headerText
        
        addArrangedSubview(headerLabel)
        if rightText != nil {
            rightButton.setTitleColor(rightTextColor, for: .normal)
            rightButton.setTitle(rightText?.uppercased(), for: .normal)
            rightButton.setTitleColor(rightTextColor.withAlphaComponent(0.5), for: .highlighted)
            rightButton.addTarget(self, action: #selector(didTapRightButton(sender:)), for: .touchUpInside)
            addArrangedSubview(rightButton)
        }
        
    }
}
