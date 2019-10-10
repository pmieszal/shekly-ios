//
//  SheklyTabBarController.swift
//  UI
//
//  Created by Patryk Mieszała on 18/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Shared

class SheklyTabBarController: UITabBarController {
    
    fileprivate lazy var addButton: UIButton = {
        let addButton = UIButton()
        
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 25
        addButton.setImage(R.image.tabBarAddButton(), for: .normal)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        return addButton
    }()
    
    private lazy var addButtonCenterYConstraint: NSLayoutConstraint = {
        return self.addButton.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupAddButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addButtonCenterYConstraint.constant = -5 - self.view.safeAreaInsets.bottom/2
        
        self.tabBar.bringSubviewToFront(addButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.addButtonCenterYConstraint.constant = -5 - self.view.safeAreaInsets.bottom/2
        
        self.tabBar.bringSubviewToFront(addButton)
    }
}

extension SheklyTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = self.viewControllers?.firstIndex(of: viewController) else {
            return false
        }
        
        return index != 2
    }
}

private extension SheklyTabBarController {
    
    func setup() {
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = Colors.brandColor
        self.tabBar.barStyle = .black
        
        self.delegate = self
    }
    
    func setupAddButton() {
        
        self.tabBar.addSubview(self.addButton)
        
        self.addButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor).isActive = true
        self.addButtonCenterYConstraint.isActive = true
    }
}

extension Reactive where Base: SheklyTabBarController {
    
    var onAddEntryTap: Signal<Void> {
        return base.addButton.rx.tap.asSignal()
    }
}
