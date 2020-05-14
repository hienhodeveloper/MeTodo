//
//  TicketView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit

class TicketView: AppView {
    private let containerHS = Init(value: AppStackView()) {
        $0.axis = .horizontal
        $0.spacing = Spacing.Medium
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    private let inforContainerVS = Init(value: AppStackView()) {
        $0.spacing = Spacing.Small
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
    }
    
    private let ticketTag = TagIconView()
    
    private let detailButton = Init(value: AppButton()) {
        $0.tintColor = R.color.lightPurpleColor()
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
    private var ticketNameLabel = Init(value: AppLabel()) {
        $0.text = "Eat Breakfast"
        $0.font = .systemFont(ofSize: FontSize.Medium, weight: .semibold)
        $0.textColor = .black
    }
    
    private var dateLabel = Init(value: AppLabel()) {
        $0.text = "Dec 25, 08:00 - 09:00"
        $0.font = .systemFont(ofSize: FontSize.Small, weight: .regular)
        $0.textColor = .systemGray3
    }
    
    var ticket: Ticket! {
        didSet {
            ticketNameLabel.text = ticket.name
            dateLabel.text = ticket.getDateTime()
            if ticket.remindMe {
                ticketTag.icon = UIImage(systemName: "bell")
            } else {
                ticketTag.icon = UIImage(systemName: "bell.slash")
            }
        }
    }
    
    override func setupView() {
        super.setupView()
        backgroundColor = .white
        cornerRad = CornerRadius.Medium
        
        addSubview(inforContainerVS)
        addSubview(containerHS)
        
        inforContainerVS.addArrangedSubview(ticketNameLabel)
        inforContainerVS.addArrangedSubview(dateLabel)
        
        containerHS.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Margin.Normal)
        }
        containerHS.addArrangedSubview(ticketTag)
        containerHS.addArrangedSubview(inforContainerVS)
        containerHS.addArrangedSubview(detailButton)
        
        ticketTag.snp.makeConstraints {
            $0.width.equalTo(AppImageSize.Large)
        }
        
        detailButton.snp.makeConstraints {
            $0.size.equalTo(IconButtonSize.Regular)
        }
    }
      
}
