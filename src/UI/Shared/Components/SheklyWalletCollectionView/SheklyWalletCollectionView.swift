//
//  SheklyWalletCollectionView.swift
//  UI
//
//  Created by Patryk Mieszała on 21/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Domain
import Shared

protocol WalletCollectionViewDataSource: class {
    func numberOfWalletItems() -> Int
    func walletCollectionView(modelForItemAt indexPath: IndexPath) -> SheklyWalletModel
}

@objc
protocol WalletCollectionViewDelegate: class {
    func walletCollectionViewDidScroll(toItemAt indexPath: IndexPath)
    func walletCollectionDidTapAdd()
}

class SheklyWalletCollectionView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        self.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32).isActive = true
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        
        self.addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3).isActive = true
        
        return pageControl
    }()
    
    weak var dataSource: WalletCollectionViewDataSource?
    weak var delegate: WalletCollectionViewDelegate?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 3)
    }

    func reload() {
        self.collectionView.reloadData()
    }
}

private extension SheklyWalletCollectionView {
    
    func setup() {
        self.backgroundColor = Colors.brandColor
        
        collectionView.register(R.nib.sheklyWalletCell)
        
        collectionView
            .rx
            .setDelegate(self)
            .dispose(in: disposeBag)
        
        collectionView
            .rx
            .setDataSource(self)
            .dispose(in: disposeBag)
        
        let didEndScrollingAnimation = collectionView
            .rx
            .didEndScrollingAnimation
            .asSignal()
        
        let didEndDecelerating = collectionView
            .rx
            .didEndDecelerating
            .asSignal()
        
        Signal
            .merge(didEndScrollingAnimation, didEndDecelerating)
            .map { [weak self] _ -> Int? in
                guard let self = self else { return nil }
                
                let offset = self.collectionView.contentOffset
                let width = self.collectionView.bounds.width
                let index = Int(offset.x / width)
                
                return index
            }
            .filterNil()
            .emit(onNext: { [weak self] (index) in
                self?.pageControl.currentPage = index
                
                let indexPath = IndexPath(row: index, section: 0)
                self?.delegate?.walletCollectionViewDidScroll(toItemAt: indexPath)
            })
            .dispose(in: disposeBag)
    }
}

extension SheklyWalletCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = dataSource?.numberOfWalletItems() ?? 0
        self.pageControl.numberOfPages = number
        
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell: SheklyWalletCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sheklyWalletCell, for: indexPath),
            let model = self.dataSource?.walletCollectionView(modelForItemAt: indexPath)
            else {
                
            return UICollectionViewCell()
        }
        
        cell.model = model
        cell.setAddButton(target: delegate, action: #selector(delegate?.walletCollectionDidTapAdd), for: .touchUpInside)
        
        return cell
    }
    
}

extension SheklyWalletCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
}
