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
    
    private func buildHomeViewController() -> UIViewController {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        return vc
    }
    
    private func buildCreateTicketViewController() -> UIViewController {
        return UIViewController()
    }
}
