//
//  HeaderView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: AppView {
   
    private var ticketNameLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: FontSize.Higher, weight: .semibold)
        $0.textColor = R.color.headerColor()!
    }
    
    var headerTitle: String? {
        didSet {
            ticketNameLabel.text = headerTitle
        }
    }
    
    override func setupView() {
        super.setupView()
        
        addSubview(ticketNameLabel)
        ticketNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Margin.Normal)
        }
    }
      
}

