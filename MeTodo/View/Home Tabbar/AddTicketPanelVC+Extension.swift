//
//  AddTicketPanelVC+Extension.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

// MARK: Section
enum TicketInforSection: Int, CaseIterable {
    case date
    case startingTime
    case remindMe
    case category
    static let count = TicketInforSection.allCases.count
}

// MARK: UITableViewDataSource
extension AddTicketPanelViewController: UITableViewDataSource {
    func reloadSections(for sections: TicketInforSection...) {
        let indexes = sections.map{ $0.rawValue }
        let indexSet = IndexSet(indexes)
        tableView.reloadSections(indexSet, with: .fade)
    }
    func reloadSection(for section: TicketInforSection) {
        tableView.reloadSections([section.rawValue], with: .fade)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TicketInforSection.count
    }
    
    // MARK: Make number row for section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowAt(tableView, cellForRowAt: indexPath)
    }
    
    // MARK: Make height for sections
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionIndex = TicketInforSection(rawValue: indexPath.section)!
        switch sectionIndex {
        case .date:
            return UITableView.automaticDimension
        case .startingTime:
            return UITableView.automaticDimension
        case .remindMe:
            return UITableView.automaticDimension
        case .category:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: Make sections for cells
    fileprivate func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndex = TicketInforSection(rawValue: indexPath.section)!
        switch sectionIndex {
        case .date:
            return makeDateCell(tableView, cellForRowAt: indexPath)
        case .startingTime:
            return makeStartingTimeCell(tableView, cellForRowAt: indexPath)
        case .remindMe:
            return makeRemindMeCell(tableView, cellForRowAt: indexPath)
        case .category:
            return makeCategoryCell(tableView, cellForRowAt: indexPath)
        }
    }
}

extension AddTicketPanelViewController {
    
    func makeDateCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<FloatingTextField>
        if cell.cellView == nil {
            let view = FloatingTextField()
            view.textField.isDisablePaste = true
            cell.margin = .init(horizontal: Margin.Normal)
            cell.cellView = view
        }
        let view = cell.cellView!
        view.tag = TicketInforSection.date.rawValue
        view.title = "Date"
        view.rightIcon = UIImage(systemName: "calendar")
        setupDatePicker(textField: view.textField)
        view.text = TimeFormatHelper.string(for: viewModel.date, format: "EEEE d, MMMM")
        return cell
    }
    
    func makeStartingTimeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<FloatingTextField>
        if cell.cellView == nil {
            let view = FloatingTextField()
            view.textField.isDisablePaste = true
            cell.margin = .init(horizontal: Margin.Normal)
            cell.cellView = view
        }
        let view =  cell.cellView!
        view.tag = TicketInforSection.startingTime.rawValue
        view.title = "Starting Time"
        view.rightIcon = UIImage(systemName: "clock")
        setupTimePicker(textField: view.textField)
        view.text = viewModel.startingTimeInString
        return cell
    }
    
    func makeRemindMeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<RemindMeView>
        if cell.cellView == nil {
            let view = RemindMeView()
            cell.margin = .init(horizontal: Margin.Normal)
            cell.cellView = view
        }
        let view = cell.cellView!
        view.delegate = self
        return cell
    }
    
    func makeCategoryCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<CategoryTagList>
        if cell.cellView == nil {
            let view = CategoryTagList()
            view.delegate = self
            cell.margin = .init(horizontal: Margin.Normal)
            cell.cellView = view
        }
        let view = cell.cellView!
        view.categoryTags = tagViewModel.listCategoryTag
        return cell
    }
}

// MARK: Footer View for each Section
extension AddTicketPanelViewController {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        16
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNonzeroMagnitude
    }
}

