//
//  TicketCalendarView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import FSCalendar
import SnapKit

class TicketCalendar: AppView {
    let calendar = Init(value: FSCalendar()) {
        $0.backgroundColor = .systemPink
    }
    
    override func setupView() {
        addSubview(calendar)
        calendar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(165)
        }
        
        calendar.calendarWeekdayView.weekdayLabels.forEach {
            $0.text = String($0.text![$0.text!.startIndex])
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
        }
        
        calendar.scope = .week
    }
    
}
