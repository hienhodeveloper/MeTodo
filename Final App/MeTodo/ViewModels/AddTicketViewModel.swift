//
//  AddTicketViewModel.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/19/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

protocol AddTicketViewModelDelegate: class {
    func addTicketViewModel(_ viewModel: AddTicketViewModel, didUpdateState state: ViewModelState)
    func addTicketViewModel(_ viewModel: AddTicketViewModel, didUpdateInputData data: TicketInputs)
}

enum TicketInputs: Int, CaseIterable {
    case name
    case date
    case workingTime
    case remindMe
    case category
    
    static let count = TicketInputs.allCases.count
}

class AddTicketViewModel {
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.addTicketViewModel(self, didUpdateState: state)
        }
    }
    
    weak var delegate: AddTicketViewModelDelegate?
    
    var name: String? {
        didSet {
            delegate?.addTicketViewModel(self, didUpdateInputData: TicketInputs.name)
        }
    }
    
    var date: Date = Date() {
        didSet {
            delegate?.addTicketViewModel(self, didUpdateInputData: TicketInputs.date)
        }
    }
    
    var workingTime: TimeInterval? {
        didSet {
            delegate?.addTicketViewModel(self, didUpdateInputData: TicketInputs.workingTime)
        }
    }
    
    var remindMe: Bool = true {
        didSet {
            delegate?.addTicketViewModel(self, didUpdateInputData: TicketInputs.remindMe)
        }
    }
    
    var category: CategoryTag? {
        didSet {
            delegate?.addTicketViewModel(self, didUpdateInputData: TicketInputs.category)
        }
    }
    
    var startingTimeInString: String {
        var startTime = "00:00"
        startTime = TimeFormatHelper.string(for: date, format: "HH:mm")
        var workTime = " -"
        if let workingTime = workingTime {
            let dateTMP = date
            workTime = " - " + TimeFormatHelper.string(for: dateTMP.addingTimeInterval(workingTime), format: "HH:mm")
        }
        return "\(startTime)\(workTime)"
    }
    
    func isEmptyTicketInfor(_ section: TicketInputs) -> Bool {
        switch section {
        case .name:
            return String.isNilOrEmpty(name)
        case .date:
            return false
        case .workingTime:
            return false
        case .remindMe:
            return false
        case .category:
            return category == nil
        }
    }
    
    func getMissingTicketInfor() -> Set<TicketInputs> {
        var missingInfo = Set<TicketInputs>()
        for sectionIndex in 0..<TicketInputs.count {
            let section = TicketInputs(rawValue: sectionIndex)!
            if isEmptyTicketInfor(section) {
                missingInfo.insert(section)
            }
        }
        return missingInfo
    }
    
    var missingTextMessgage: String {
        let missing = getMissingTicketInfor()
        var message = "Please fill\n"
        for field in missing {
            if field == .name { message += "[Ticket name] "}
            if field == .category { message += "[Category] "}
        }
        return message.trimmingCharacters(in: .whitespaces)
    }
    
    private func makeATicket() -> Ticket {
        return .init(name: name!,
                     category: category!.id,
                     startingTime: .init(date: date),
                     workingTime: Int(workingTime ?? 0),
                     isDone: false,
                     remindMe: remindMe)
    }
    
    func addTicket() {
        guard state == .idle else { return }
        state = .loading
        FirestoreManager.shared.addTicket(ticket: makeATicket(),success: { [weak self] ticket in
            guard let self = self else { return }
            self.state = .idle
            AppNavigator.shared.dismiss()
            }, failure: { [weak self] error in
                self?.state = .error(error)
        })
    }
}

