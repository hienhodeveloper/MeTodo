//
//  TaskViewController.swift
//  Todo
//
//  Created by Jake Shelley on 12/13/17.
//  Copyright © 2017 Jake Shelley. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

protocol TaskViewControllerDelegate: class {
    func dismissDetailView(deletedActiveTask: Bool)
}

class TaskViewController: UIViewController {
    
    var task: Task!
    var taskList: TaskList!
    var completed: Bool!
    var taskTextViewHeightConstraint: Constraint!
    var noteTextViewHeightConstraint: Constraint!
    private var keyboardIsShown = false
    private var savedYValue:CGFloat = 0
    private var dismissKeyboardSwipe: UISwipeGestureRecognizer!
    lazy var closeImageView = UIImageView()
    lazy var trashImageView = UIImageView()
    lazy var taskTextView = UITextView()
    lazy var statusLabel = UILabel()
    lazy var scrollView = UIScrollView()
    lazy var textViewPlaceholder = UILabel()
    weak var delegate: TaskViewControllerDelegate?
    private var kBuffer: CGFloat!
    lazy var dateLabel = UILabel()
    lazy var dateTextField = AppTextField()
    lazy var levelLabel = UILabel()
    lazy var levelTextField = AppTextField()
    
    lazy var datePicker = UIDatePicker()
    lazy var levelPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kBuffer = 15 + (UIScreen.main.bounds.width - MINIMIZED_LIST_WIDTH)/2
        applyDismissKeyboardGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        buildUI()
        datePicker.date = task.dueDate
        showDatePicker()
        showLevelPicker()
        levelPicker.selectRow(TaskLevel.allCases.firstIndex(of: task.taskLevel)!, inComponent: 0, animated: true)
        donedatePicker()
        doneLevelPicker()
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        closeView(deletedTask: false)
    }
    
    
    private func buildUI() {
        view.backgroundColor = .white
        
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        
        closeImageView.image = UIImage(named: "x")
        closeImageView.tintColor = .lightGray
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeView))
        closeImageView.addGestureRecognizer(closeTap)
        closeImageView.isUserInteractionEnabled = true
        
        trashImageView.image = UIImage(named: "trash")
        trashImageView.tintColor = .redOrange
        trashImageView.isUserInteractionEnabled = true
        let deleteTap = UITapGestureRecognizer(target: self, action: #selector(deleteTaskPrompt))
        trashImageView.addGestureRecognizer(deleteTap)
        
        var statusText = "TODO"
        if (completed) {
            statusText = R.string.localization.completed().uppercased()
        }
        
        statusLabel.text = statusText
        statusLabel.font = getPrimaryFont(.medium, size: 15)
        statusLabel.textColor = .lightGray
        
        taskTextView.text = task.text
        taskTextView.font = getPrimaryFont(.medium, size: 22)
        taskTextView.textColor = .black
        taskTextView.translatesAutoresizingMaskIntoConstraints = true
        taskTextView.isScrollEnabled = false
        taskTextView.sizeToFit()
        taskTextView.showsVerticalScrollIndicator = false
        taskTextView.delegate = self
        
        dateLabel.text = R.string.localization.date()
        dateLabel.font = getPrimaryFont(.medium, size: 15)
        dateLabel.textColor = .lightGray
        
        dateTextField.font = getPrimaryFont(.medium, size: 22)
        dateTextField.tintColor = .black
        dateTextField.isDisableAllAction = true
        
        levelLabel.text = R.string.localization.level()
        levelLabel.font = getPrimaryFont(.medium, size: 15)
        levelLabel.textColor = .lightGray
        
        levelTextField.font = getPrimaryFont(.medium, size: 22)
        levelTextField.tintColor = .black
        levelTextField.isDisableAllAction = true

        view.addSubview(scrollView)
        
        scrollView.addSubviews([statusLabel, taskTextView, closeImageView, trashImageView, dateLabel, dateTextField, levelLabel, levelTextField])
    }

    private func setConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self.view)
        }
        
        closeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(15)
            make.height.width.equalTo(20)
        }

        trashImageView.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.height.width.equalTo(18)
            make.right.equalTo(view.snp.right).offset(-15)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(closeImageView.snp.bottom).offset(30)
            make.left.equalTo(kBuffer)
        }
        
        taskTextView.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.left.equalTo(statusLabel).offset(-6)
            make.width.equalTo(MINIMIZED_LIST_WIDTH)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kBuffer)
            make.top.equalTo(taskTextView.snp.bottom).offset(16)
        }
        
        dateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalTo(dateLabel).offset(-6)
            make.width.equalTo(MINIMIZED_LIST_WIDTH)
        }
        
        levelLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kBuffer)
            make.top.equalTo(dateTextField.snp.bottom).offset(16)
        }
        
        levelTextField.snp.makeConstraints { (make) in
            make.top.equalTo(levelLabel.snp.bottom).offset(10)
            make.left.equalTo(levelLabel).offset(-6)
            make.width.equalTo(MINIMIZED_LIST_WIDTH)
        }
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: R.string.localization.done(), style: .done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton], animated: false)
        
        // add toolbar to textField
        dateTextField.inputAccessoryView = toolbar
        // add datepicker to textField
        dateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    
    func showLevelPicker(){
        //Formate Date
        levelPicker.dataSource = self
        levelPicker.delegate = self
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: R.string.localization.done(), style: .done, target: self, action: #selector(doneLevelPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton], animated: false)
        
        // add toolbar to textField
        levelTextField.inputAccessoryView = toolbar
        // add datepicker to textField
        levelTextField.inputView = levelPicker
        
    }
    
    @objc func doneLevelPicker(){
        let selectedIndex = levelPicker.selectedRow(inComponent: 0)
        levelTextField.text = TaskLevel.allCases[selectedIndex].text
    }
    
    private func applyDismissKeyboardGesture() {
        dismissKeyboardSwipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardSwipe.direction = .down
        dismissKeyboardSwipe.delegate = self
        view.addGestureRecognizer(dismissKeyboardSwipe)
    }
    
    private func deleteTask() {
        let id = task.id
        let realm = try! Realm()
        try! realm.write {
            realm.delete(task)
        }
        MeNotificationManager.shared.cancelNotifications(ids: [id])
        closeView(deletedTask: true)
    }
    
    @objc func closeView(deletedTask: Bool = false) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        if (!completed && deletedTask) {
            delegate?.dismissDetailView(deletedActiveTask: true)
        } else {
            delegate?.dismissDetailView(deletedActiveTask: false)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
    }
    
    @objc func dismissKeyboard() {
        scrollView.setContentOffset(CGPoint(x: 0, y: savedYValue), animated: true)
        
        scrollView.isScrollEnabled = true
        if (taskTextView.text == "") {
            taskTextView.text = task.text
        } else {
            let id = task.id
            let realm = try! Realm()
            guard let text = taskTextView.text, text.count > 0 else { return }
            guard let _date = dateTextField.text, _date.count > 0 else { return }
            guard let _level = levelTextField.text, _level.count > 0 else { return }
            let level = levelPicker.selectedRow(inComponent: 0)
            let levelTask = TaskLevel.allCases[level].rawValue
            let date = datePicker.date
            guard text != "" else { return }
            
            try! realm.write {
                task.text = text
                task.level = levelTask
                task.dueDate = date
            }
            
            let contentTitle = "\(text) - \(R.string.localization.level()): \(TaskLevel.allCases[level].text) "
            MeNotificationManager.shared.schedule(id: id, contentTitle: contentTitle, date: date )
        }
        
        if (taskTextViewHeightConstraint != nil) {
            taskTextViewHeightConstraint.deactivate()
        }
        
        if (noteTextViewHeightConstraint != nil) {
            noteTextViewHeightConstraint.deactivate()
        }
        
        taskTextView.isScrollEnabled = false
        //noteTextView.isScrollEnabled = false
        
        view.endEditing(true)
    }
    
    @objc func deleteTaskPrompt() {
        let alert = UIAlertController(title: "Are you sure?", message: "This task and all it's associated data will be deleted. This cannot be undone", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteTask()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)        
    }
    
}

extension TaskViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension TaskViewController: UIScrollViewDelegate {
    
}

extension TaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
       
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        keyboardIsShown = false
    }
    
}
extension TaskViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TaskLevel.allCases[row].text
    }
    
}

extension TaskViewController: UIPickerViewDelegate {
    
}
