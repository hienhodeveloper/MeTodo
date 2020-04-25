//
//  RemindMeView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/16/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

protocol RemindMeViewDelegate: class {
    func remindMeView(_ view: RemindMeView, didChangedRemindMe isOn: Bool)
}

class RemindMeView: AppView {
    weak var delegate: RemindMeViewDelegate?
    
    private let containerHS = Init(value: AppStackView()) {
        $0.axis = .horizontal
        $0.spacing = Spacing.Medium
        $0.alignment = .center
    }
    
    private let tagView = TagIconView()
    
    private let titleLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: FontSize.Higher, weight: .regular)
        $0.text = "Remind Me"
    }
    
    private let switchView = Init(value: UISwitch()) {
        $0.onTintColor = R.color.dimPurpleColor()!
        $0.isOn = true
    }
    
    override func setupView() {
        super.setupView()
        addSubview(containerHS)
        containerHS.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tagView.snp.makeConstraints {
            $0.width.equalTo(AppImageSize.Large)
        }
        containerHS.addArrangedSubview(tagView)
        containerHS.addArrangedSubview(titleLabel)
        containerHS.addArrangedSubview(switchView)
        
        switchView.addTarget(self, action: #selector(switchChangedValue), for: .valueChanged)
    }

    @objc func switchChangedValue(_ sender: UISwitch) {
        delegate?.remindMeView(self, didChangedRemindMe: sender.isOn)
        if sender.isOn {
            tagView.icon = UIImage(systemName: "bell")
        } else {
            tagView.icon = UIImage(systemName: "bell.slash")
        }
    }
}
