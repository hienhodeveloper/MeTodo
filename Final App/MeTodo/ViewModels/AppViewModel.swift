//
//  AppViewModel.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

enum ViewModelState: Equatable {
    case loading
    case idle
    case error(AppError)
}
