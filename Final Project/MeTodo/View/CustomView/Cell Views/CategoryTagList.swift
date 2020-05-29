//
//  CategoryTagList.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/17/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import TagListView
import CoreData

protocol CategoryTagListDelegate: class {
    func categoryTagList(_ view: CategoryTagList, didTapAddTag button: AppButton)
    func categoryTagList(_ view: CategoryTagList, updatedSelectTag tag: Category?)
}

class CategoryTagList: AppView {
    weak var delegate: CategoryTagListDelegate?
    var selectedTag: TagView?
    
    private let containerVS = Init(value: AppStackView()) {
        $0.spacing = Spacing.Medium
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
       }
    
    private lazy var listTagView: TagListView = {
        let view = TagListView()
        view.delegate = self
        view.tagSelectedBackgroundColor = R.color.dimPurpleColor()!
        view.selectedTextColor = .white
        view.marginX = 8
        view.marginY = 8
        view.paddingX = 26
        view.paddingY = 12
        view.cornerRadius = CornerRadius.Medium
        view.textFont = .systemFont(ofSize: FontSize.Medium, weight: .medium)
        view.borderColor = .clear
        return view
    }()
    
    private let titleLabel = Init(value: AppLabel()) {
        $0.font = .systemFont(ofSize: FontSize.Medium, weight: .regular)
        $0.text = R.string.localization.category()
        $0.textColor = R.color.titleTextFieldColor()!
    }
    
    var categoryTags: [Category] = [] {
        didSet {
            listTagView.removeAllTags()
            guard categoryTags.count > 0 else { return }
            categoryTags.forEach { tag in
                let tagView = listTagView.addTag(tag.name!)
                tagView.textColor = R.color.dimPurpleColor()!
                tagView.tagBackgroundColor = UIColor.red.withAlphaComponent(0.1)
            }
        }
    }
    
    var addTagButton = Init(value: AppButton()) {
        $0.setTitle("Add Tag", for: .normal)
        $0.setTitleColor(UIColor.orange.withAlphaComponent(0.6), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: FontSize.Medium, weight: .semibold)
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.tintColor = UIColor.orange.withAlphaComponent(0.6)
        $0.backgroundColor =  UIColor.orange.withAlphaComponent(0.15)
        $0.cornerRad = 18
        $0.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        $0.imageView?.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        $0.addTarget(self, action: #selector(didTapAddCategory(sender:)), for: .touchUpInside)
    }
    
    override func setupView() {
        super.setupView()
        addSubview(containerVS)
        containerVS.addArrangedSubview(titleLabel)
        containerVS.addArrangedSubview(listTagView)
        
        let addTagButtonContainer = AppStackView()
        addTagButtonContainer.axis = .horizontal
        addTagButtonContainer.isUserInteractionEnabled = true
        addTagButtonContainer.addArrangedSubview(AppView())
        addTagButtonContainer.addArrangedSubview(addTagButton)
        
        containerVS.addArrangedSubview(addTagButtonContainer)
        containerVS.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

    @objc func didTapAddCategory(sender: AppButton) {
        delegate?.categoryTagList(self, didTapAddTag: sender)
    }
}
// MARK: TagListViewDelegate

extension CategoryTagList: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if tagView == selectedTag {
            selectedTag!.isSelected = !selectedTag!.isSelected
            if selectedTag!.isSelected == false {
                selectedTag = nil
            }
        } else {
            selectedTag?.isSelected = false
            selectedTag = tagView
            selectedTag?.isSelected = true
        }
        let tag = categoryTags.first{$0.name == title}
        delegate?.categoryTagList(self, updatedSelectTag: tag)
        
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        // print("Tag Remove pressed: \(title), \(sender)")
        //sender.removeTagView(tagView)
    }
}
