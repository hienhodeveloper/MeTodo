//
//  TicketTagView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit

class TicketTagView: AppView {
    
    private let ticketImageView = Init(value: AppImageView()) {
        $0.backgroundColor = .clear
        $0.image = UIImage(systemName: "book")
        $0.contentMode = .scaleAspectFit
    }

    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.red.withAlphaComponent(0.1)
        cornerRadius = CornerRadius.Regular
        
        addSubview(ticketImageView)
        ticketImageView.snp.makeConstraints {
            $0.size.equalTo(AppImageSize.Regular)
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
