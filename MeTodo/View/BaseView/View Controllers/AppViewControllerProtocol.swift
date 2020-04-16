//
//  AppViewControllerProtocol.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

protocol AppViewControllerProtocol {
    var navigationTitle: String? { get }
    var backgroundColor: UIColor { get }
    var prefersLargeTitles: Bool { get }
    var isHiddenNavigationBar: Bool { get }
    
    func addSubviews()
    func setupUI()
    func registeNotifications()
    func beginAnimate()
    func endAnimate()
}
