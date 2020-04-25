//
//  LiquidViewController.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import liquid_swipe

class LiquidViewController: LiquidSwipeContainerController, LiquidViewControllerProtocol {
    
    deinit {
        print("DEINIT \(self)")
    }
    
    var navigationTitle: String? { nil }
    var backgroundColor: UIColor { R.color.appBackgroundColor()! }
    var prefersLargeTitles: Bool { false }
    var isHiddenNavigationBar: Bool { true }
    
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
}
