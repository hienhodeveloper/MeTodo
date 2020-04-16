//
//  RemindMeView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/16/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

class RemindMeView: AppView {

    var containerHS = Init(value: AppStackView()) {
        $0.axis = .horizontal
        $0.spacing = Spacing.Small
        
    }

}
