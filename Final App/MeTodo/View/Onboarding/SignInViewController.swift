//
//  SignInViewController.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift

typealias SignInVC = SignInViewController

protocol SignInViewControllerDelegate: class {
    func signInViewController(_ controller: SignInViewController, didTapSignUp button: AppButton)
}

class SignInViewController: AppViewController {
    deinit {
        
    }
    
    let headerView = Init(value: OnboardHeaderView()) {
        $0.headerText = R.string.localization.letSignIn()
        $0.rightText = R.string.localization.signUp()
        $0.headerTextColor = .white
        $0.rightTextColor = R.color.signUpBackgroundColor()!
    }
    
    let containerVS = Init(value: AppStackView()) {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = Spacing.Medium
    }
    
    let emailTextField = Init(value: AppTextField()) {
        $0.autocapitalizationType = .none
        $0.placeholder = R.string.localization.email()
        $0.keyboardType = .emailAddress
        $0.backgroundColor = .white
        $0.cornerRad = CornerRadius.Medium
        
    }
    
    let passwordTextField = Init(value: AppTextField()) {
        $0.placeholder = R.string.localization.password()
        $0.isSecureTextEntry = true
        $0.backgroundColor = .white
        $0.cornerRad = CornerRadius.Medium
        
    }
    
    let signInButton = Init(value: AppButton()) {
        $0.setTitle(R.string.localization.signIn(), for: .normal)
        $0.backgroundColor = .orange
        $0.isEnabled = false
        $0.alpha = 0.5
        
    }
    
    weak var delegate: SignInViewControllerDelegate?
    
    @objc func didChangeTextField(sender: AppTextField) {
        let newValue = sender.text ?? ""
        switch sender {
        case emailTextField:
            viewModel.email = newValue
        case passwordTextField:
            viewModel.password = newValue
        default: break
        }
    }
    
    @objc func didTapSignInButton(sender: UIButton) {
        viewModel.startSignIn()
    }
    
    var viewModel = SignInViewModel()
    
    override var backgroundColor: UIColor { R.color.signInBackgroundColor()! }
    override var isHiddenNavigationBar: Bool { true }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(headerView)
        view.addSubview(containerVS)
        containerVS.addArrangedSubview(emailTextField)
        containerVS.addArrangedSubview(passwordTextField)
        containerVS.addArrangedSubview(signInButton)
    }
    
    override func setupUI() {
        super.setupUI()
        containerVS.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Margin.Regular)
            $0.size.equalTo(CGSize(width: AppScreenSize.screenWidth - 5 * Margin.Medium , height: 165))
        }
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Margin.Large)
            $0.right.equalToSuperview().offset(-Margin.Hight)
            $0.left.equalToSuperview().offset(Margin.Regular)
        }
        headerView.delegate = self
        viewModel.delegate = self
        emailTextField.addTarget(self, action: #selector(didChangeTextField(sender:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangeTextField(sender:)), for: .editingChanged)
        signInButton.addTarget(self, action: #selector(didTapSignInButton(sender:)), for: .touchUpInside)
    }
}

extension SignInVC: SignInViewModelDelegate {
    func signInViewModel(_ viewModel: SignInViewModel, didUpdateState state: ViewModelState) {
        switch viewModel.state {
        case .error(let error):
            showMessage(title: "Error", message: error.appErrorDescription)
        case .idle:
            NotificationCenter.default.post(name: Notification.Name.SignInSuccess, object: nil)
        default:
            break;
        }
    }
    
    func signInViewModel(_ viewModel: SignInViewModel, didUpdateInputData data: SignInInput) {
        if viewModel.hasValidCredentials {
            signInButton.alpha = 1.0
            signInButton.isEnabled = true
        } else {
            signInButton.alpha = 0.5
             signInButton.isEnabled = false
        }
    }
}


extension SignInVC: OnboardHeaderViewDelegate {
    func onboardHeaderView(_ view: OnboardHeaderView, didTapRightButton button: AppButton) {
        delegate?.signInViewController(self, didTapSignUp: button)
    }
}
