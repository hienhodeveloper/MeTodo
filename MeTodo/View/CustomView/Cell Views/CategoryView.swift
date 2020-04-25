//
//  TagCategoryView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

class CategoryView: AppView {
    private var backgroundImage = Init(value: AppImageView()) {
        $0.contentMode = .scaleToFill
    }
    
    private var categoryNameLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: FontSize.Higher, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    var categoryTitle: String? {
        didSet {
            categoryNameLabel.text = categoryTitle
        }
    }
    
    override func setupView() {
        super.setupView()
        backgroundColor = .white
        cornerRad = CornerRadius.Medium
        addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Margin.Normal)
             $0.left.equalToSuperview().inset(Margin.Normal)
             $0.right.equalToSuperview().inset(Margin.Normal)
            $0.bottom.lessThanOrEqualToSuperview().inset(Margin.Normal)
        }
    }
    
}

