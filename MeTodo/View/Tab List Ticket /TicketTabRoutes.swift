//
//  TicketRoutes.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

enum TicketTabRoutes: Route {
    case listTickets
    
    var screen: UIViewController {
        switch self {
        case .listTickets:
            return buildListTicketViewController()
        }
    }
    
    private func buildListTicketViewController() -> ListTicketViewController {
        let viewController = ListTicketViewController()
        return viewController
    }
}

