//
//  ListTicketViewController.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit
import FSCalendar

class ListTicketViewController: AppViewController{
    let tableView = Init(value: UITableView(frame: .zero, style: .grouped)) {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    let calendar = Init(value: FSCalendar()) {
        $0.backgroundColor = .white
    }
    
    let containerView = Init(value: AppView()) {
        $0.backgroundColor = R.color.appBackgroundColor()
        $0.cornerRadius = CornerRadius.Large
        $0.effectCornerRadiusSide = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override var isHiddenNavigationBar: Bool { true }
    override var backgroundColor: UIColor { .white }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(containerView)
        containerView.addSubview(tableView)
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registClassCell(GenericTableViewCell<TicketView>.self)
        tableView.registClassCell(GenericTableViewCell<TicketCategoryCollection>.self)
    }
}

extension ListTicketViewController: UITableViewDelegate {
    
}
