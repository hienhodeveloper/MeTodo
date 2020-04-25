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
import DeepDiff

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
        $0.cornerRad = CornerRadius.Large
        $0.effectCornerRadiusSide = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        refreshControl.addTarget(self, action:
            #selector(ListTicketViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    var viewModel = ListTicketViewModel()
    
    override var isHiddenNavigationBar: Bool { true }
    override var backgroundColor: UIColor { .white }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        refreshControl.beginRefreshing()
        reloadData()
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
        viewModel.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.registClassCell(GenericTableViewCell<TicketView>.self)
        tableView.registClassCell(GenericTableViewCell<TicketCategoryCollection>.self)
    }
    
    private func reloadData() {
        viewModel.getListTicket()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        reloadData()
    }
}

extension ListTicketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        animationCell(cell:cell)
    }
    
    func animationCell(cell: UITableViewCell) {
        let rotation = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotation
        cell.alpha = 0.5
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: { () -> Void in
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completion) in
            self.handleRemoveTicket(indexPath: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = R.color.appBackgroundColor()!
        deleteAction.image = UIImage(systemName: "trash.fill")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        return .init(actions: [deleteAction])
    }
    
    private func handleRemoveTicket(indexPath: IndexPath) {
        
    }
}

extension ListTicketViewController: ListTicketViewModelDelegate {
    func listTicketViewModel(_ viewModel: ListTicketViewModel, didUpdateState state: ViewModelState) {
        switch viewModel.state {
        case .loading:
            refreshControl.beginRefreshing()
        case .error(let error):
            refreshControl.endRefreshing()
            showMessage(title: "Error", message: error.appErrorDescription)
        case .idle:
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
}
