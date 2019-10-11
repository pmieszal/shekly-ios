//
//  WalletHeaderView.swift
//  UI
//
//  Created by Patryk Mieszała on 19/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared

class WalletHeaderView: UIView {
    private lazy var walletCollectionView: SheklyWalletCollectionView = {
        let view = SheklyWalletCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        return view
    }()
    
    private lazy var monthView: SheklyMonthCollectionView = {
        let view = SheklyMonthCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        return view
        
    }()
    
    weak var walletDataSource: WalletCollectionViewDataSource? {
        get {
            return walletCollectionView.dataSource
        }
        set {
            walletCollectionView.dataSource = newValue
        }
    }
    
    weak var walletDelegate: WalletCollectionViewDelegate? {
        get {
            return walletCollectionView.delegate
        }
        set {
            walletCollectionView.delegate = newValue
        }
    }
    
    weak var monthCollectionDelegate: SheklyMonthCollectionViewDelegate? {
        get {
            return monthView.delegate
        }
        set {
            monthView.delegate = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 3)
    }
    
    func reloadWalletCollectionView() {
        walletCollectionView.reload()
    }
}

private extension WalletHeaderView {
    func setup() {
        backgroundColor = Colors.brand2Color
        
        walletCollectionView.bottomAnchor.constraint(equalTo: monthView.topAnchor).isActive = true
        monthView.topAnchor.constraint(equalTo: walletCollectionView.bottomAnchor).isActive = true
    }
}
