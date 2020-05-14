//
//  TicketCategoryCollection.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/13/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import Rswift

//protocol TicketCategoryCollectionDeletegate: class {
//    func reviewSection(_ section: TicketCategoryCollection, didTapSeeAll button: UIButton)
//    func reviewSection(_ section: TicketCategoryCollection, didSelectedReview review: ReviewModel, reviewIndexPath: IndexPath)
//}

class TicketCategoryCollection: AppView {
    
    private var collectionView: UICollectionView!
    
    private let collectionViewLayout = Init(value: UPCarouselFlowLayout()) {
        $0.scrollDirection = .horizontal
        $0.sideItemScale = 1.0
        $0.sideItemAlpha = 1.0
        $0.sideItemShift = 0
        $0.spacingMode = .fixed(spacing: Spacing.Medium)
    }
    
    // weak var delegate: ReviewSectionDeletegate?
    
    //    var reviewList: [ReviewModel]? {
    //        didSet {
    //            resizeCell()
    //            collectionView.reloadData()
    //       }
    //    }
    
    private let cellSize = CGSize(width: 156, height: 208)
    
    override func setupView() {
        super.setupView()
        collectionViewLayout.itemSize = cellSize

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.contentInset = createContentInset()

        addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registClassCell(GenericCollectionViewCell<CategoryView>.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createContentInset() -> UIEdgeInsets {
        let horizontalContentInset =  -1 * (AppScreenSize.screenWidth  - cellSize.width) / 2 + Spacing.Medium * 2
        let contentInset: UIEdgeInsets = .init(top:0,left: horizontalContentInset, bottom: 0, right: horizontalContentInset)
        return contentInset
    }
}

extension TicketCategoryCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<CategoryView>
        guard cell.cellView != nil else {
            let view = CategoryView()
            view.categoryTitle = "hello"
            cell.cellView = view
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
