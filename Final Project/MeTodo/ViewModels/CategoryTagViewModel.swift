//
//  CategoryTagViewModel.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/19/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import Foundation

protocol CategoryViewModelDelegate: class {
    func categoryTagViewModel(_ viewModel: CategoryTagViewModel, didUpdateState state: ViewModelState)
}

class CategoryTagViewModel {
    weak var delegate: CategoryViewModelDelegate?

    var listCategoryTag: [CategoryTag] = []
    
    var numberOfCategoryTag: Int {
        listCategoryTag.count
    }
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.categoryTagViewModel(self, didUpdateState: state)
        }
    }
    
    func getListCategoryTag() {
        guard state == .idle else { return }
        state = .loading
        FirestoreManager.shared.getListCategoryTag(success: { [weak self] listTag in
            guard let self = self else { return }
            self.listCategoryTag.removeAll()
            self.listCategoryTag = listTag
            self.state = .idle
        }, failure: { [weak self] error in
            self?.state = .error(error)
        })
    }
    
    func addCategoryTag(name: String) {
        guard state == .idle, !isAvailabelTag(name: name) else { return }
        state = .loading
        FirestoreManager.shared.addCategoryTag(tag: .init(name: name),success: { [weak self] tag in
            guard let self = self else { return }
            self.listCategoryTag.append(tag)
            self.state = .idle
        }, failure: { [weak self] error in
            self?.state = .error(error)
        })
    }
    
    func isAvailabelTag(name: String) -> Bool {
        return listCategoryTag.first { $0.name == name } != nil
    }
}


