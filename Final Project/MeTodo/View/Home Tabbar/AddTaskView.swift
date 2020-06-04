//
//  AddTaskView.swift
//  Todo
//
//  Created by Jake Shelley on 12/10/17.
//  Copyright © 2017 Jake Shelley. All rights reserved.
//

import UIKit

protocol AddTaskViewDelegate: class {
    func updateButtonFrame(with keyboardHeight : CGFloat)
    func closeAddTaskView()
}

class AddTaskView: UIView {
    
    var primaryColor: UIColor!
    private var kBuffer: CGFloat!
    weak var delegate: AddTaskViewDelegate?
    lazy var textView = UITextView()
    lazy var closeImageView = UIImageView()
    lazy var textLabel = UILabel()
    lazy var titleLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var dateTextField = AppTextField()
    lazy var levelLabel = UILabel()
    lazy var levelTextField = AppTextField()
    
    lazy var datePicker = UIDatePicker()
    lazy var levelPicker = UIPickerView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func build() {
        backgroundColor = .white
        applyDismissKeyboardGesture()
        kBuffer = 15 + (UIScreen.main.bounds.width - MINIMIZED_LIST_WIDTH)/2
        buildUI()
        setConstraints()
        showDatePicker()
        showLevelPicker()
        alpha = 0
    }
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func showView() {
        textView.becomeFirstResponder()
        textView.text = ""
    }
    
    func hideView() {
        dismissKeyboard()
    }
    
    private func buildUI() {
        titleLabel.text = R.string.localization.newTask()
        titleLabel.font = getPrimaryFont(.medium, size: 16)
        titleLabel.textAlignment = .center
        
        closeImageView.image = UIImage(named: "x")
        closeImageView.tintColor = .lightGray
        closeImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        closeImageView.addGestureRecognizer(tapGesture)
        
        textLabel.text = R.string.localization.askTodo()
        textLabel.font = getPrimaryFont(.medium, size: 15)
        textLabel.textColor = .lightGray
        
        dateLabel.text = R.string.localization.date()
        dateLabel.font = getPrimaryFont(.medium, size: 15)
        dateLabel.textColor = .lightGray
        
        textView.font = getPrimaryFont(.medium, size: 22)
        textView.tintColor = primaryColor
        
        dateTextField.font = getPrimaryFont(.medium, size: 22)
        dateTextField.tintColor = primaryColor
        dateTextField.isDisableAllAction = true
        
        levelLabel.text = R.string.localization.level()
        levelLabel.font = getPrimaryFont(.medium, size: 15)
        levelLabel.textColor = .lightGray
        
        levelTextField.font = getPrimaryFont(.medium, size: 22)
        levelTextField.tintColor = primaryColor
        levelTextField.isDisableAllAction = true

        addSubviews([textView, closeImageView, textLabel, titleLabel, dateLabel, dateTextField, levelLabel, levelTextField])
    }
    
    private func setConstraints() {
        closeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(SAFE_BUFFER)
            make.left.equalTo(16)
            make.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(closeImageView)
            make.height.equalTo(20)
            make.centerX.equalTo(self)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kBuffer)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(10)
            make.left.equalTo(textLabel).offset(-6)
            make.width.equalTo(MINIMIZED_LIST_WIDTH)
            make.height.equalTo(60)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kBuffer)
            make.top.equalTo(textView.snp.bottom).offset(16)
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
    
    // Mark: Keyboard
    
    private func applyDismissKeyboardGesture() {
        let dismissKeyboardGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardGesture.direction = .down
        dismissKeyboardGesture.delegate = self
        self.addGestureRecognizer(dismissKeyboardGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            textView.snp.makeConstraints { (make) in
                make.height.equalTo(UIScreen.main.bounds.height - textView.frame.origin.y - keyboardSize.height - 50)
            }
            
            self.layoutIfNeeded()
            delegate?.updateButtonFrame(with: keyboardSize.height)
        }
        
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
        delegate?.closeAddTaskView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

extension AddTaskView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension AddTaskView: UIPickerViewDataSource {
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

extension AddTaskView: UIPickerViewDelegate {
    
}
