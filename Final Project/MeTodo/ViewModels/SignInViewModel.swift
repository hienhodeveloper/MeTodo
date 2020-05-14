//
//  SignInViewModel.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

protocol SignInViewModelDelegate: class {
    func signInViewModel(_ viewModel: SignInViewModel, didUpdateState state: ViewModelState)
    func signInViewModel(_ viewModel: SignInViewModel, didUpdateInputData data: SignInInput)
}

enum SignInInput {
    case email
    case password
}

class SignInViewModel {
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.signInViewModel(self, didUpdateState: state)
        }
    }
    
    weak var delegate: SignInViewModelDelegate?
    
    var email = "" {
        didSet {
            delegate?.signInViewModel(self, didUpdateInputData: SignInInput.email)
        }
    }
    
    var password = "" {
        didSet {
            delegate?.signInViewModel(self, didUpdateInputData: SignInInput.password)
        }
    }
    
    var hasValidCredentials: Bool {
        return email.isEmailFormatted() && !password.isEmpty
    }
    
    func startSignIn() {
        state = .loading
        FirebaseManager.shared.signIn(email: email, password: password, success: {[weak self] in
            guard let self = self else { return }
            self.state = .idle
            AppNavigator.shared.navigate(to: HomeRoutes.home, with: .reset)
            }, failure: { [weak self] error in
                self?.state = .error(error)
        })
    }
}

