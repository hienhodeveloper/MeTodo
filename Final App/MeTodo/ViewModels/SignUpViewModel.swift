//
//  SignUpViewModel.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

protocol SignUpViewModelDelegate: class {
    func signUpViewModel(_ viewModel: SignUpViewModel, didUpdateState state: ViewModelState)
    func signUpViewModel(_ viewModel: SignUpViewModel, didUpdateInputData data: SignUpInput)
}

enum SignUpInput {
    case email
    case password
    case confirmPassword
}

class SignUpViewModel {
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.signUpViewModel(self, didUpdateState: state)
        }
    }
    
    weak var delegate: SignUpViewModelDelegate?
    
    var email = "" {
        didSet {
            delegate?.signUpViewModel(self, didUpdateInputData: SignUpInput.email)
        }
    }
    
    var password = "" {
        didSet {
            delegate?.signUpViewModel(self, didUpdateInputData: SignUpInput.password)
        }
    }
    
    var confirmPassword = "" {
        didSet {
            delegate?.signUpViewModel(self, didUpdateInputData: SignUpInput.confirmPassword)
        }
    }
    
    var hasValidCredentials: Bool {
        if password != confirmPassword {
            return false
        }
        return email.isEmailFormatted() && !password.isEmpty
    }
    
    func startSignUp() {
        state = .loading
        FirebaseManager.shared.signUp(email: email, password: password, success: {[weak self] in
            guard let self = self else { return }
            self.state = .idle
            AppNavigator.shared.navigate(to: HomeRoutes.home, with: .reset)
            }, failure: { [weak self] error in
                self?.state = .error(error)
        })
    }
}


