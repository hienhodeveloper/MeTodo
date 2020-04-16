//
//  UITableView.swift
//  MeChat
//
//  Created by Hien Ho Developer on 4/5/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

extension UITableView {
    // For generic table view cells
    func registClassCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: (Cell.name))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.name) as? Cell else {
            fatalError("Error for cell if: \(Cell.name) at \(indexPath)")
        }
        return cell
    }
}
