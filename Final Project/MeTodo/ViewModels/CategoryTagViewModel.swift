//
//  CategoryViewModel.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/19/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import CoreData

protocol CategoryViewModelDelegate: class {
    func CategoryViewModel(_ viewModel: CategoryViewModel, didUpdateState state: ViewModelState)
}

class CategoryViewModel {
    weak var delegate: CategoryViewModelDelegate?
    
    lazy var context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    }()
    
    var listCategory: [Category] = []
    
    var numberOfCategory: Int {
        listCategory.count
    }
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.CategoryViewModel(self, didUpdateState: state)
        }
    }
    
    func getListCategory() {
        guard state == .idle else { return }
        state = .loading
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            self.listCategory = try context.fetch(request)
            self.state = .idle
            print("Load success")
        } catch {
            print("Load error: \(error)")
            state = .error(.init(from: error as NSError))
        }
    }
    
    func addCategory(name: String) {
        guard state == .idle, !isAvailabelTag(name: name) else { return }
        state = .loading
        let category = Category(context: context)
        category.name = name
        listCategory.append(category)
        save()
    }
    
    func isAvailabelTag(name: String) -> Bool {
        return listCategory.first { $0.name == name } != nil
    }
    
    func save() {
        do {
            try context.save()
            print("Save Category success")
            self.state = .idle
        } catch {
            self.state = .error(.init(from: error as NSError))
        }
    }
}


