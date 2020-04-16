//
//  SignUpViewController.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift

typealias SignUpVC = SignUpViewController

protocol SignUpViewControllerDelegate: class {
    func signUpViewController(_ controller: SignUpViewController, didTapGoBack button: AppButton)
}

class SignUpViewController: AppViewController {
    let headerView = Init(value: OnboardHeaderView()) {
        $0.headerText = R.string.localization.letSignUp()
        $0.headerTextColor = .white
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
        $0.cornerRadius = CornerRadius.Medium
        $0.addTarget(self, action: #selector(SignUpVC.didChangeTextField(sender:)), for: .editingChanged)
    }
    
    let passwordTextField = Init(value: AppTextField()) {
        $0.placeholder = R.string.localization.password()
        $0.isSecureTextEntry = true
        $0.backgroundColor = .white
        $0.cornerRadius = CornerRadius.Medium
        $0.addTarget(self, action: #selector(SignUpVC.didChangeTextField(sender:)), for: .editingChanged)
    }
    
    let confirmPasswordTextField = Init(value: AppTextField()) {
        $0.placeholder = R.string.localization.password()
        $0.isSecureTextEntry = true
        $0.backgroundColor = .white
        $0.cornerRadius = CornerRadius.Medium
        $0.addTarget(self, action: #selector(SignUpVC.didChangeTextField(sender:)), for: .editingChanged)
    }
    
    let signUpButton = Init(value: AppButton()) {
        $0.setTitle(R.string.localization.signUp(), for: .normal)
        $0.backgroundColor = .orange
        $0.isEnabled = false
        $0.alpha = 0.5
        $0.addTarget(self, action: #selector(SignUpVC.didTapsignUpButton(sender:)), for: .touchUpInside)
    }
    
    weak var delegate: SignUpViewControllerDelegate?
    
    @objc func didChangeTextField(sender: AppTextField) {
        let newValue = sender.text ?? ""
        switch sender {
        case emailTextField:
            viewModel.email = newValue
        case passwordTextField:
            viewModel.password = newValue
        case confirmPasswordTextField:
            viewModel.confirmPassword = newValue
        default: break
        }
    }
    
    @objc func didTapsignUpButton(sender: UIButton) {
        viewModel.startSignUp()
    }
    
    var viewModel = SignUpViewModel()
    
    override var backgroundColor: UIColor { R.color.signUpBackgroundColor()! }
    override var isHiddenNavigationBar: Bool { true }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(headerView)
        view.addSubview(containerVS)
        containerVS.addArrangedSubview(emailTextField)
        containerVS.addArrangedSubview(passwordTextField)
        containerVS.addArrangedSubview(confirmPasswordTextField)
        containerVS.addArrangedSubview(signUpButton)
    }
    
    override func setupUI() {
        super.setupUI()
        containerVS.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Margin.Regular)
            $0.size.equalTo(CGSize(width: AppScreenSize.screenWidth - 5 * Margin.Medium , height: 220))
        }
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Margin.Large)
            $0.right.equalToSuperview().offset(-Margin.Hight)
            $0.left.equalToSuperview().offset(Margin.Regular)
        }
        headerView.delegate = self
        viewModel.delegate = self
    }
}

extension SignUpVC: OnboardHeaderViewDelegate {
    func onboardHeaderView(_ view: OnboardHeaderView, didTapRightButton button: AppButton) {
        delegate?.signUpViewController(self, didTapGoBack: button)
    }
}

extension SignUpVC: SignUpViewModelDelegate {
    func signUpViewModel(_ viewModel: SignUpViewModel, didUpdateState state: ViewModelState) {
        switch viewModel.state {
        case .error(let error):
            showMessage(title: "Error", message: error.appErrorDescription)
        case .idle:
            NotificationCenter.default.post(name: Notification.Name.SignUpSuccess, object: nil)
        default:
            break;
        }
    }
    
    func signUpViewModel(_ viewModel: SignUpViewModel, didUpdateInputData data: SignUpInput) {
        if viewModel.hasValidCredentials {
            signUpButton.alpha = 1.0
            signUpButton.isEnabled = true
        } else {
            signUpButton.alpha = 0.5
            signUpButton.isEnabled = false
        }
    }
}
