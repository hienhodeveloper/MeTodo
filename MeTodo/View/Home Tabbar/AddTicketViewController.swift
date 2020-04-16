//
//  AddTicketViewController.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

typealias AddTicketVC = AddTicketViewController
class AddTicketViewController: AppViewController {
    
    let containerView = Init(value: AppView()) {
        $0.backgroundColor = R.color.lightOrangeColor()
        $0.cornerRadius = CornerRadius.Large
    }
    
    let backButton = Init(value: AppButton()) {
        $0.setImage(R.image.leftArrowIcon()!, for: .normal)
        $0.imageView?.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        $0.addTarget(self, action: #selector(AddTicketVC.didTapBackButton), for: .touchUpInside)
    }
    
    @objc func didTapBackButton(_ sender: AppButton) {
        AppNavigator.shared.dismiss()
    }
    
    let headerlabel = Init(value: AppLabel()) {
        $0.text = "Create\nNew Task"
        $0.textColor = R.color.headerColor()!
        $0.font = .systemFont(ofSize: FontSize.Header, weight: .semibold)
        $0.numberOfLines = 0
    }
    
    let ticketNameTextField = Init(value: FloatingTextField()) {
        $0.text = "my love"
        $0.textField.font = .systemFont(ofSize: FontSize.Higher, weight: .medium)
    }
    
    let bodyContainer = Init(value: AppView()) {
        $0.backgroundColor = .white
        $0.cornerRadius = CornerRadius.Large
    }
    
    let tableView = Init(value: UITableView(frame: .zero, style: .grouped) ) {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    let createButton = Init(value: AppButton() ) { view in
        view.backgroundColor = R.color.dimPurpleColor()
        view.setTitle("CREATE TASK", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.cornerRadius = CornerRadius.Regular
        view.titleLabel?.font = .systemFont(ofSize: FontSize.Regular, weight: .bold)
        view.setImage(R.image.addTabIcon()!, for: .normal)
        view.imageView?.tintColor = R.color.lightPurpleColor()
        view.imageView?.snp.makeConstraints { make in
            make.size.equalTo(IconButtonSize.Regular)
            make.right.equalTo(view.titleLabel!.snp.left).offset(-Margin.Small)
        }
    }
    
    override var backgroundColor: UIColor { .white }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(headerlabel)
        containerView.addSubview(ticketNameTextField)
        containerView.addSubview(bodyContainer)
        
        bodyContainer.addSubview(tableView)
        bodyContainer.addSubview(createButton)
    }
    
    override func setupUI() {
        super.setupUI()
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Margin.Tiny)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Margin.Normal)
            $0.left.equalToSuperview().inset(Margin.Normal)
            $0.size.equalTo(IconButtonSize.Regular)
        }
        
        headerlabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).inset(-Margin.Normal)
            $0.left.equalToSuperview().inset(Margin.Normal)
        }
        
        ticketNameTextField.snp.makeConstraints {
            $0.top.equalTo(headerlabel.snp.bottom).inset(-40)
            $0.left.equalToSuperview().inset(Margin.Normal)
            $0.right.equalToSuperview().inset(Margin.Normal)
        }
        
        bodyContainer.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(ticketNameTextField.snp.bottom).inset(-32)
        }
        
        createButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Margin.Normal)
            $0.left.equalToSuperview().inset(Margin.Normal)
            $0.right.equalToSuperview().inset(Margin.Normal)
            $0.height.equalTo(64)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Margin.Regular)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalTo(createButton.snp.top).offset(Margin.Normal)
        }
        
        tableView.registClassCell(GenericTableViewCell<FloatingTextField>.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func beginAnimate() {
        let rotation = CATransform3DTranslate(CATransform3DIdentity, 0, 100, 0)
        bodyContainer.layer.transform = rotation
        bodyContainer.alpha = 0.5
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: { () -> Void in
            self.bodyContainer.layer.transform = CATransform3DIdentity
            self.bodyContainer.alpha = 1.0
        }, completion: nil)
    }
    
    override func endAnimate() {

    }
}

extension AddTicketViewController: UITableViewDelegate {
    
}
