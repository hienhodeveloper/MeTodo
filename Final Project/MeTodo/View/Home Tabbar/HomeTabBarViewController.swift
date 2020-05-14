//
//  HomeTabBarViewController.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift

typealias HomeTabBarVC = HomeTabBarViewController
class HomeTabBarViewController: UITabBarController, AppViewControllerProtocol {
    
    private let createTicketButton = Init(value: AppButton()) {
        $0.tintColor = R.color.dimPurpleColor()!
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.imageView?.snp.makeConstraints{
            $0.size.equalToSuperview()
        }
        $0.addTarget(self, action: #selector(HomeTabBarVC.didTapCreateTicket), for: .touchUpInside)
    }
    
    @objc func didTapCreateTicket(_ sender: AppButton) {
        AppNavigator.shared.navigate(to: HomeRoutes.createTicket, with: .modal(.fullScreen))
    }
    
    var navigationTitle: String?
    
    var backgroundColor: UIColor { R.color.appBackgroundColor()! }
    
    var prefersLargeTitles: Bool { false }
    
    var isHiddenNavigationBar: Bool { true }

    var ticketNavigator: AppNavigator = .init(with: TicketTabRoutes.listTickets)
    // var addTicketNavigator: AppNavigator = .init(with: AddTicketTabRoutes.addTicket)
    
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
        view.addSubview(createTicketButton)
    }
    
    func setupUI() {
        createTicketButton.snp.makeConstraints {
            $0.bottom.equalTo(tabBar.snp.top).inset(-Margin.Normal)
            $0.right.equalToSuperview().inset(Margin.Normal)
            $0.size.equalTo(IconButtonSize.Big)
        }
        
        tabBar.barTintColor = R.color.tabBarTintColor()!
        tabBar.tintColor = R.color.dimPurpleColor()
        
        let listTicketVC = ticketNavigator.currentViewController!
        listTicketVC.tabBarItem = .init(title: nil, image: R.image.menuTabIcon()!, tag: 0)
        listTicketVC.tabBarItem.imageInsets = .init(top: 6, left: 0, bottom: -6, right: 0);
        
        viewControllers = [ticketNavigator.rootViewController!]
    }
    
    func registeNotifications() {
        
    }
    
    func beginAnimate() {
        
    }
    
    func endAnimate() {
        
    }
}
