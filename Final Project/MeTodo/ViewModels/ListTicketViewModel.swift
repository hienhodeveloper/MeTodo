//
//  HomeViewModel.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/18/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//
import Foundation
import DeepDiff
import CoreData

protocol ListTicketViewModelDelegate: class {
    func listTicketViewModel(_ viewModel: ListTicketViewModel, didUpdateState state: ViewModelState)
}

class ListTicketViewModel {
    
    var listTicketToday: [Ticket] = []
    var listOtherTicket: [Ticket] = []
    
    lazy var context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    }()
    
    var numberOfTodayTicket: Int {
        listTicketToday.count
    }

    var numberOfOtherTicket: Int {
        listOtherTicket.count
    }
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.listTicketViewModel(self, didUpdateState: state)
        }
    }
    
    weak var delegate: ListTicketViewModelDelegate?
    
    func getListTicket(with request: NSFetchRequest<Ticket> = Ticket.fetchRequest()) {
        guard state == .idle else { return }
        state = .loading
        let request: NSFetchRequest<Ticket> = Ticket.fetchRequest()
        do {
            let todoList = try context.fetch(request)
            handleListTicket(todoList)
            print("Load success")
        } catch {
            print("Load error: \(error)")
            state = .error(.init(from: error as NSError))
        }
    }
    
    private func handleListTicket(_ list: [Ticket]) {
        let listTicketToday = list.filter {
            TimeFormatHelper.isToday(date: $0.startingTime!)
        }
        self.listTicketToday = listTicketToday.reversed()
        
        let listOtherTicket = list.filter {
            !TimeFormatHelper.isToday(date: $0.startingTime!)
        }
       
        self.listOtherTicket = listOtherTicket
        
        state = .idle
    }
    
    func isEndTodayTicket(_ indexPath: IndexPath) -> Bool {
        return numberOfTodayTicket == indexPath.row + 1
    }
    
    func isEndOtherTicket(_ indexPath: IndexPath) -> Bool {
        return numberOfOtherTicket == indexPath.row + 1
    }
    
    func todayTicketAt(_ indexPath: IndexPath) -> Ticket {
        return listTicketToday[indexPath.row]
    }
    
    func otherTicketAt(_ indexPath: IndexPath) -> Ticket {
        return listOtherTicket[indexPath.row]
    }
}


