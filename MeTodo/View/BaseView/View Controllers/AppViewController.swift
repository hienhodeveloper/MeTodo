//
//  AppBaseViewController.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/4/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift

class AppViewController: UIViewController, AppViewControllerProtocol {
    
    var navigationTitle: String? { nil }
    var backgroundColor: UIColor { R.color.appBackgroundColor()! }
    var prefersLargeTitles: Bool { false }
    var isHiddenNavigationBar: Bool { false }
    
    deinit {
        print("DEINIT \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        addSubviews()
        setupUI()
        registeNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController?.setNavigationBarHidden(isHiddenNavigationBar, animated: true)
        beginAnimate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endAnimate()
    }
    
    func addSubviews() {
        
    }
    
    func setupUI() {
        
    }
    
    func registeNotifications() {
        
    }
    
    func beginAnimate() {
        
    }
    
    func endAnimate() {
        
    }
    
    func embedInDismissKeyboardView(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UIView) {
        view.endEditing(true)
    }
    
}
