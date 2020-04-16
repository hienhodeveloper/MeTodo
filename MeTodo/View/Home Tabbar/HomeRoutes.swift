//
//  HomeRoutes.swift
//  ios-base
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import UIKit

enum HomeRoutes: Route {
    case home
    case createTicket
    
    var screen: UIViewController {
        switch self {
        case .home:
            return buildHomeViewController()
        case .createTicket:
            return buildCreateTicketViewController()
        }
    }
    
    private func buildHomeViewController() -> HomeTabBarViewController {
        let viewController = HomeTabBarViewController()
        return viewController
    }
    
    private func buildCreateTicketViewController() -> AddTicketViewController {
        let viewController = AddTicketViewController()
        return viewController
    }
}
