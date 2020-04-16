//
//  FirstViewController.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/4/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift
import SnapKit
import liquid_swipe

typealias OnboardVC = OnboardViewController

class OnboardViewController: LiquidViewController {
    var viewControllers: [UIViewController] = []
    
    override func setupUI() {
        super.setupUI()
        let startPageVC = StartVC()
        startPageVC.delegate = self
        let signInPageVC = SignInVC()
        signInPageVC.delegate = self
        let signUpPageVC = SignUpVC()
        signUpPageVC.delegate = self
        viewControllers = [startPageVC, signInPageVC, signUpPageVC]
        datasource = self
    }
    
    override func registeNotifications() {
        super.registeNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(signInSuccess), name: Notification.Name.SignInSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signUpSuccess), name: Notification.Name.SignUpSuccess, object: nil)
    }
    
    @objc func signInSuccess(_ notification: Notification) {
        // TODO: we need to release all view controller to avoid least memory before go Home Routes
        viewControllers = []
        datasource = nil
    }
    @objc func signUpSuccess(_ notification: Notification) {
        // TODO: we need to release all view controller to avoid least memory before go Home Routes
        viewControllers = []
        datasource = nil
    }
}

extension OnboardViewController: LiquidSwipeContainerDataSource{
    
    func numberOfControllersInLiquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController) -> Int {
        return viewControllers.count
    }
    
    func liquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController, viewControllerAtIndex index: Int) -> UIViewController {
        return viewControllers[index]
    }
}

extension OnboardViewController: StartViewControllerDelegate {
    func startViewController(_ controller: StartViewController, didTapSignIn button: AppButton) {
        handleTapNextButton()
    }
}

extension OnboardViewController: SignInViewControllerDelegate {
    func signInViewController(_ controller: SignInViewController, didTapSignUp button: AppButton) {
        handleTapNextButton()
    }
}

extension OnboardViewController: SignUpViewControllerDelegate {
    func signUpViewController(_ controller: SignUpViewController, didTapGoBack button: AppButton) {
    }
}
