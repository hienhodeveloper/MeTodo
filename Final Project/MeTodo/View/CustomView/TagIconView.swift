//
//  TicketTagView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit

class TagIconView: AppView {
    
    private let ticketImageView = Init(value: AppImageView()) {
        $0.backgroundColor = .clear
        $0.tintColor = R.color.dimPurpleColor()
        $0.image = UIImage(systemName: "bell")
        $0.contentMode = .scaleAspectFit
    }

    var icon: UIImage? {
        didSet {
            ticketImageView.image = icon
        }
    }
    
    var iconTintColor: UIColor? {
        didSet {
            ticketImageView.tintColor = iconTintColor
        }
    }
    
    var color: UIColor = R.color.lightBlueColor()! {
        didSet {
            backgroundColor = color
        }
    }
    
    override func setupView() {
        super.setupView()
        backgroundColor = color
        cornerRad = CornerRadius.Regular
        addSubview(ticketImageView)
        ticketImageView.snp.makeConstraints {
            $0.size.equalTo(AppImageSize.Regular)
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
