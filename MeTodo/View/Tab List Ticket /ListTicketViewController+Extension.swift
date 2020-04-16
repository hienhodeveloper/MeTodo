//
//  ListTicketViewController+Extension.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift

enum ListTicketSection: Int, CaseIterable {
    case today
    case tomorrow
    static let count = ListTicketSection.allCases.count
}

extension ListTicketViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListTicketSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ListTicketSection(rawValue: section)! {
        case .today:
            return 3
        case .tomorrow:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        switch ListTicketSection(rawValue: section)! {
        case .today:
            header.headerTitle = "Today"
            
        case .tomorrow:
            header.headerTitle = "Tommorow"
            
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ListTicketSection(rawValue: indexPath.section)! {
        case .today:
            return UITableView.automaticDimension
        case .tomorrow:
            return 208
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ListTicketSection(rawValue: indexPath.section)! {
        case .today:
            return makeTodayCell(tableView, cellForRowAt: indexPath)
        case .tomorrow:
            return makeTomorrowCell(tableView, cellForRowAt: indexPath)
        }
    }
}

extension ListTicketViewController {
    private func makeTodayCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<TicketView>
        if cell.cellView == nil {
            let view = TicketView()
            cell.cellView = view
            cell.outsideCellViewColor = R.color.appBackgroundColor()!
            // TODO: create func to check cell is the last cell of section
        }
        cell.margin = .init(top: 0, left: Margin.Normal, bottom: indexPath.row == 2 ? 0: Spacing.Medium, right: Margin.Normal)
        return cell
    }
    
    private func makeTomorrowCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<TicketCategoryCollection>
        if cell.cellView == nil {
            let view = TicketCategoryCollection()
            cell.cellView = view
            // TODO: create func to check cell is the last cell of section
            // cell.margin = .init(top: 0, left: Margin.Normal, bottom: indexPath.row == 2 ? 0: Spacing.Medium, right: Margin.Normal)
        }
        return cell
    }
}

