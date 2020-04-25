//
//  AddTicketViewController.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/12/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import FloatingPanel

typealias AddTicketVC = AddTicketViewController
class AddTicketViewController: AppViewController {
    
    let containerView = Init(value: AppView()) {
        $0.backgroundColor = R.color.lightOrangeColor()
        $0.cornerRad = CornerRadius.Large
    }
    
    let backButton = Init(value: AppButton()) {
        $0.setImage(R.image.leftArrowIcon()!, for: .normal)
        $0.iconSize = .init(width: 24, height: 24)
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
        $0.title = "Name"
        $0.isHiddenRightButton = true
        $0.textField.font = .systemFont(ofSize: FontSize.Higher, weight: .medium)
        $0.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    let createButton = Init(value: AppButton() ) { view in
        view.backgroundColor = R.color.dimPurpleColor()
        view.setTitle("CREATE TASK", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.cornerRad = CornerRadius.Regular
        view.titleLabel?.font = .systemFont(ofSize: FontSize.Regular, weight: .bold)
        view.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        view.imageView?.tintColor = R.color.lightPurpleColor()
        view.imageEdgeInsets = .init(onlyRight:Margin.Medium)
        view.addTarget(self, action: #selector(createTicket), for: .touchUpInside)
    }

    var addTicketPanel: FloatingPanelController!
    let contentVC = AddTicketPanelViewController()
    var isUpdatedHalfPanelHeight = false
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override var backgroundColor: UIColor { .white }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(headerlabel)
        containerView.addSubview(ticketNameTextField)
        
        embedInDismissKeyboardView(view: containerView)
    }
    
    override func setupUI() {
        super.setupUI()
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Margin.Tiny)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Margin.Normal)
            $0.left.equalToSuperview().inset(Margin.Normal)
            $0.size.equalTo(IconButtonSize.Hight)
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
        
        addTicketPanel = FloatingPanelController()
        addTicketPanel.surfaceView.backgroundColor = .white
        addTicketPanel.surfaceView.cornerRadius = CornerRadius.Large
        addTicketPanel.surfaceView.shadowHidden = true
        addTicketPanel.delegate = self
        
        addTicketPanel.set(contentViewController: contentVC)
        addTicketPanel.track(scrollView: contentVC.tableView)
        addTicketPanel.addPanel(toParent: self)
        
        view.addSubview(createButton)
        
        createButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Margin.Medium)
            $0.left.equalToSuperview().inset(Margin.Normal+Margin.Small)
            $0.right.equalToSuperview().inset(Margin.Normal+Margin.Small)
            $0.height.equalTo(60)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addTicketPanel.removePanelFromParent(animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if ticketNameTextField.frame.origin.y != 0.0, isUpdatedHalfPanelHeight == false {
            addTicketPanel.updateLayout()
            isUpdatedHalfPanelHeight = true
        }
    }
    
    @objc func textFieldChanged(sender: AppTextField) {
        contentVC.viewModel.name = sender.text
    }
    
    @objc func createTicket(sender: AppButton) {
        let missingFields = contentVC.viewModel.getMissingTicketInfor()
        guard missingFields.count == 0 else {
            showMessage(title: contentVC.viewModel.missingTextMessgage, message: "")
            return
        }
        contentVC.viewModel.addTicket()
    }
}

extension AddTicketViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        var heightTop = view.safeAreaInsets.top
        if heightTop <= 20 {
            heightTop = 0
        }
        let height = AppScreenSize.screenHeight - heightTop - (ticketNameTextField.frame.origin.y + ticketNameTextField.bounds.size.height + Margin.Normal)
        return FloatingPanelStocksLayout(halfHeight: height)
    }
}

class FloatingPanelStocksLayout: FloatingPanelLayout {
    var halfHeight: CGFloat!
    
    init(halfHeight: CGFloat) {
        self.halfHeight = halfHeight
    }
    
    var initialPosition: FloatingPanelPosition {
        return .half
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 56.0
        case .half: return halfHeight
        default: return nil
        }
    }
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .half]
    }
    
    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
            surfaceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8.0)
        ]
    }
}
