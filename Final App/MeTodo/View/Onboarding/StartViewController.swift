//
//  StartViewController.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/4/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import Rswift
import SnapKit

typealias StartVC = StartViewController

protocol StartViewControllerDelegate: class {
    func startViewController(_ controller: StartViewController, didTapSignIn button: AppButton)
}

class StartViewController: AppViewController {
    let containerVS = Init(value: AppStackView()) {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalCentering
        $0.spacing = 0
    }
    
    let sloganVS = Init(value: AppStackView()) {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = Spacing.Small
    }
    
    
    let slogan = Init(value: AppLabel()) {
        $0.text = "Create\nyour future!"
        $0.font = .systemFont(ofSize: FontSize.Big, weight: .bold)
        $0.numberOfLines = 2
    }
    
    let subcribe = Init(value: AppLabel()) {
        $0.text = "Make your life better by yourself. Enjoy 🥳"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: FontSize.Medium, weight: .regular)
        $0.numberOfLines = 2
    }
    
    let headerView = Init(value: OnboardHeaderView()) {
        $0.headerText = AppStringPlist.AppName.text
        $0.rightText = R.string.localization.signIn()
        $0.rightTextColor = R.color.signInBackgroundColor()!
    }
    
    let posterImage = Init(value: UIImageView()) {
        $0.image = R.image.taskImage()
    }
 
    weak var delegate: StartViewControllerDelegate?
    
    override var isHiddenNavigationBar: Bool { true }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(containerVS)
        sloganVS.addArrangedSubview(slogan)
        sloganVS.addArrangedSubview(subcribe)
        
        containerVS.addArrangedSubview(headerView)
        
        let posterContainerView = AppView()
        posterContainerView.addSubview(posterImage)
        
        containerVS.addArrangedSubview(posterContainerView)
        containerVS.addArrangedSubview(sloganVS)
    }
    
    override func setupUI() {
        super.setupUI()
        containerVS.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Margin.Large)
            $0.bottom.equalToSuperview().inset(2 * Margin.Hight)
            $0.left.equalToSuperview().inset(Margin.Regular)
            $0.right.equalToSuperview().offset(-Margin.Hight)
        }
        posterImage.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-Margin.Hight)
            $0.size.equalTo(CGSize(width: 200, height: 200))
        }
        headerView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension StartViewController: OnboardHeaderViewDelegate {
    func onboardHeaderView(_ view: OnboardHeaderView, didTapRightButton button: AppButton) {
        delegate?.startViewController(self, didTapSignIn: button)
    }
}
