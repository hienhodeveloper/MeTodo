//
//  GenericCollectionViewCell.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/17/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import SnapKit

class GenericCollectionViewCell<View: AppView>: UICollectionViewCell {
    var cellView: View? {
        didSet {
            setUpViews()
        }
    }
    
    /// Using for set space between cells
    var margin: UIEdgeInsets = .zero {
        didSet {
            updateCellMargin()
        }
    }
    
    // Color for OUTSIDE of <cellView>
    var outsideCellViewColor: UIColor? {
        didSet {
            updateCellOusideColor()
        }
    }
    
    override func prepareForReuse() {
        subviews.forEach {
           ($0 as? AppView)?.setDefaultValues()
        }
    }
    
    private func setUpViews() {
        clearAllSubviews()
        guard let cellView = cellView else { return }
        addSubview(cellView)
        updateCellMargin()
        updateCellOusideColor()
    }
    
    private func clearAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func updateCellMargin() {
        guard let cellView = cellView else { return }
        cornerRad = cellView.cornerRad
        cellView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(margin)
        }
    }
    
    private func updateCellOusideColor() {
        guard let cellView = cellView else { return }
        if let outCellViewColor = outsideCellViewColor {
            backgroundColor = outCellViewColor
        } else {
            backgroundColor = cellView.backgroundColor
        }
    }
}
