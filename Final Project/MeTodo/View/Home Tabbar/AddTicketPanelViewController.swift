//
//  AddTicketVC+Extension.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/15/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

class AddTicketPanelViewController: AppViewController {
    let tableView = Init(value: UITableView(frame: .zero, style: .grouped) ) {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    let datePicker = Init(value: UIDatePicker()) {
        $0.datePickerMode = .dateAndTime
    }
    
    let timePicker = Init(value: UIDatePicker()) {
        $0.datePickerMode = .countDownTimer
    }
    
    var viewModel = AddTicketViewModel()
    var tagViewModel = CategoryTagViewModel()
    
    override func addSubviews() {
        super.addSubviews()
        embedInDismissKeyboardView(view: view)
        view.addSubview(tableView)
        
    }
    
    override func setupUI() {
        super.setupUI()
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        tableView.registClassCell(GenericTableViewCell<FloatingTextField>.self)
        tableView.registClassCell(GenericTableViewCell<RemindMeView>.self)
        tableView.registClassCell(GenericTableViewCell<CategoryTagList>.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = self
        tagViewModel.delegate = self
        
        tagViewModel.getListCategoryTag()
    }
    
    func setupDatePicker(textField: AppTextField) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDoneForDatePicker))
        toolbar.setItems([doneBtn], animated: true)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    func setupTimePicker(textField: AppTextField) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDoneForTimePicker))
        toolbar.setItems([doneBtn], animated: true)
        textField.inputAccessoryView = toolbar
        textField.inputView = timePicker
    }
    
    @objc func didTapDoneForDatePicker() {
        view.endEditing(true)
        guard datePicker.date != viewModel.date else { return }
        viewModel.date = datePicker.date
    }
    
    @objc func didTapDoneForTimePicker() {
        view.endEditing(true)
        guard timePicker.countDownDuration != viewModel.workingTime else { return }
        viewModel.workingTime = timePicker.countDownDuration
    }
}

extension AddTicketPanelViewController: UITableViewDelegate {
    
}

extension AddTicketPanelViewController: AddTicketViewModelDelegate {
    
    func addTicketViewModel(_ viewModel: AddTicketViewModel, didUpdateState state: ViewModelState) {
        
    }
    
    func addTicketViewModel(_ viewModel: AddTicketViewModel, didUpdateInputData data: TicketInputs) {
        switch data {
        case .date:
            reloadSections(for: .date, .startingTime)
        case .workingTime:
            reloadSection(for: .startingTime)
        case .remindMe:
            // DON'T reload section remind in here
            // It causes "kCFRunLoopCommonModes" warning
            break
        case .category:
            break
        case .name:
            break
        }
    }
    
    
}

extension AddTicketPanelViewController: FloatingTextFieldDelegate {
    func floatingTextField(_ view: FloatingTextField, didTapRightButton button: AppButton) {
        
    }
}

extension AddTicketPanelViewController: RemindMeViewDelegate {
    func remindMeView(_ view: RemindMeView, didChangedRemindMe isOn: Bool) {
        viewModel.remindMe = isOn
    }
}

extension AddTicketPanelViewController: CategoryViewModelDelegate {
    func categoryTagViewModel(_ viewModel: CategoryTagViewModel, didUpdateState state: ViewModelState) {
        switch viewModel.state {
        case .loading:
            break
        case .error( _):
            break
            // showMessage(title: "Error", message: error.appErrorDescription)
        case .idle:
            reloadSection(for: .category)
        }
    }
}

extension AddTicketPanelViewController: CategoryTagListDelegate {
    func categoryTagList(_ view: CategoryTagList, updatedSelectTag tag: CategoryTag?) {
        viewModel.category = tag
    }
    
    func categoryTagList(_ view: CategoryTagList, didTapAddTag button: AppButton) {
        showAddCategoryAlert()
    }
    
    func showAddCategoryAlert() {
        let alert = UIAlertController(title: "Create your tag", message: "", preferredStyle: .alert)
        
        var todoTextField: UITextField!
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            guard let self = self, let todo = todoTextField.text else { return }
            guard todo.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return }
            self.tagViewModel.addCategoryTag(name: todo)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alert.addTextField {
            alertTextField in
            todoTextField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
