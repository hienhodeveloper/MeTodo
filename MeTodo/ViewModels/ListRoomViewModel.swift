//
//  ListRoomViewModel.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

protocol ListRoomViewModelDelegate: class {
    func listRoomViewModel(_ viewModel: ListRoomViewModel, didUpdateState state: ViewModelState)
}

class ListRoomViewModel {
    
    var state: ViewModelState = .idle {
        didSet {
            delegate?.listRoomViewModel(self, didUpdateState: state)
        }
    }
    
    weak var delegate: ListRoomViewModelDelegate?
        
    func startSignIn() {
        state = .loading

    }
}

