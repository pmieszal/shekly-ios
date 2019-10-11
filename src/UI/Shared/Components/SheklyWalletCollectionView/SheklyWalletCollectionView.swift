//
//  SheklyWalletCollectionView.swift
//  UI
//
//  Created by Patryk Mieszała on 21/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Domain
import Shared

protocol WalletCollectionViewDataSource: AnyObject {
    func numberOfWalletItems() -> Int
    func walletCollectionView(modelForItemAt indexPath: IndexPath) -> SheklyWalletModel
}

@objc
protocol WalletCollectionViewDelegate: AnyObject {
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath)
    func walletCollectionDidTapAdd()
}

class SheklyWalletCollectionView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        
        addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 3).isActive = true
        
        return pageControl
    }()
    
    weak var dataSource: WalletCollectionViewDataSource?
    weak var delegate: WalletCollectionViewDelegate?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 3)
    }

    func reload() {
        collectionView.reloadData()
    }
}

extension SheklyWalletCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = dataSource?.numberOfWalletItems() ?? 0
        pageControl.numberOfPages = number
        
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell: SheklyWalletCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sheklyWalletCell, for: indexPath),
            let model = dataSource?.walletCollectionView(modelForItemAt: indexPath)
            else {
                
            return UICollectionViewCell()
        }
        
        cell.model = model
        cell.setAddButton(target: delegate, action: #selector(delegate?.walletCollectionDidTapAdd), for: .touchUpInside)
        
        return cell
    }
    
}

extension SheklyWalletCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = getCurrentCollectionIndex()
        pageControl.currentPage = index
        
        let indexPath = IndexPath(row: index, section: 0)
        delegate?.walletCollectionViewDidScroll(toItemAt: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentCollectionIndex()
        pageControl.currentPage = index
        
        let indexPath = IndexPath(row: index, section: 0)
        delegate?.walletCollectionViewDidScroll(toItemAt: indexPath)
    }
}

private extension SheklyWalletCollectionView {
    func setup() {
        backgroundColor = Colors.brandColor
        
        collectionView.register(R.nib.sheklyWalletCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func getCurrentCollectionIndex() -> Int {
        let offset = collectionView.contentOffset
        let width = collectionView.bounds.width
        let index = Int(offset.x / width)
        
        return index
    }
}
