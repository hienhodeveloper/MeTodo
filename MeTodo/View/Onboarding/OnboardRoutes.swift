//
//  OnboardingRoutes.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/4/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

enum OnboardingRoutes: Route {
    case onboard
    case startScreen
    case signIn
    case signUp
    
    var screen: UIViewController {
        switch self {
        case .onboard:
            return buildOnboardViewController()
        case .startScreen:
            return buildStartViewController()
        case .signIn:
            return buildSignInViewController()
        case .signUp:
            return buildSignUpViewController()
        }
    }
    
    private func buildSignInViewController() -> AppViewController {
        let viewController = SignInViewController()
        return viewController
    }
    
    private func buildSignUpViewController() -> AppViewController {
        let viewController = SignUpViewController()
        return viewController
    }
    
    private func buildOnboardViewController() -> OnboardViewController {
        let viewController = OnboardViewController()
        return viewController
    }
    
    private func buildStartViewController() -> AppViewController {
        let viewController = StartViewController()
        return viewController
    }
}

