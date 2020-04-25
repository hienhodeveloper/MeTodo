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
    case other
    static let count = ListTicketSection.allCases.count
}

extension ListTicketViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListTicketSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ListTicketSection(rawValue: section)! {
        case .today:
            return viewModel.numberOfTodayTicket
        case .other:
            return viewModel.numberOfOtherTicket
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        switch ListTicketSection(rawValue: section)! {
        case .today:
            header.headerTitle = "Today"
            
        case .other:
            header.headerTitle = "Other"
            
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ListTicketSection(rawValue: indexPath.section)! {
        case .today:
            return UITableView.automaticDimension
        case .other:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ListTicketSection(rawValue: indexPath.section)! {
        case .today:
            return makeTodayCell(tableView, cellForRowAt: indexPath)
        case .other:
            return makeOtherCell(tableView, cellForRowAt: indexPath)
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
        }
        cell.cellView?.ticket = viewModel.todayTicketAt(indexPath)
        cell.margin = .init(top: 0, left: Margin.Normal, bottom: viewModel.isEndTodayTicket(indexPath) ? 0: Spacing.Medium, right: Margin.Normal)
        return cell
    }
    
    private func makeOtherCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<TicketView>
        if cell.cellView == nil {
            let view = TicketView()
            cell.cellView = view
            cell.outsideCellViewColor = R.color.appBackgroundColor()!
        }
        cell.cellView?.ticket = viewModel.otherTicketAt(indexPath)
        cell.margin = .init(top: 0, left: Margin.Normal, bottom: viewModel.isEndOtherTicket(indexPath) ? 0: Spacing.Medium, right: Margin.Normal)
        return cell
    }
}

