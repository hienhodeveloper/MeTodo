//
//  UICollectionView.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registClassCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: Cell.name)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.name, for: indexPath) as? Cell else {
            fatalError("Error for cell if: \(Cell.name) at \(indexPath)")
        }
        return cell
    }
}
