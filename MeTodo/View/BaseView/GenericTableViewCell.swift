//
//  GenericTableViewCell.swift
//  student
//
//  Created by Hien Ho on 3/3/20.
//

import UIKit
import SnapKit

extension UIEdgeInsets {
    init(horizontal: CGFloat) {
        self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }
    
    init(vertical: CGFloat) {
        self.init(top: vertical, left: 0, bottom: vertical, right: 0)
    }
}

/** * Description: Class to make a UITableViewCell from a custom view
    * Example: <NewPresidentProfileViewController.swift>
    - To registe cell: tableView.regisCell(GenericTableViewCell<EmptySectionView>.self)
    with "EmptySectionView" is your custom view
    - To reuse cell:
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<EmptySectionView>
    guard let cellView = cell.cellView else {
        let emptyEventView: EmptySectionView = .fromNib()
        cell.cellView = emptyEventView
        return cell
    }
     // set Data here
     cellView.title = "Section title"
    * NOTE: at <guard> above, cell will always keep instance of <cellView>, you can remove it if you want to recreate <cellView> EVERYTIME
 */
class GenericTableViewCell<View: AppView>: UITableViewCell {
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        cornerRadius = cellView.cornerRadius
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

