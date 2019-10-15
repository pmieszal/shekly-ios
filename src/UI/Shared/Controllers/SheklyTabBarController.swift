//
//  SheklyTabBarController.swift
//  UI
//
//  Created by Patryk Mieszała on 18/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Shared

class SheklyTabBarController: UITabBarController {
    private lazy var addButton: UIButton = {
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
        return addButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor)
    }()
    
    var router: TabRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Setting up add button target on will appear,
        //since tab bar is "special" type of ViewController,
        //and it calls viewDidLoad on super.init
        setupAddButtonTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addButtonCenterYConstraint.constant = -5 - view.safeAreaInsets.bottom/2
        
        tabBar.bringSubviewToFront(addButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        addButtonCenterYConstraint.constant = -5 - view.safeAreaInsets.bottom/2
        
        tabBar.bringSubviewToFront(addButton)
    }
}

extension SheklyTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else {
            return false
        }
        
        return index != 2
    }
}

private extension SheklyTabBarController {
    func setup() {
        tabBar.tintColor = .white
        tabBar.barTintColor = Colors.brandColor
        tabBar.barStyle = .black
        
        delegate = self
    }
    
    func setupAddButton() {
        tabBar.addSubview(addButton)
        
        addButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        addButtonCenterYConstraint.isActive = true
    }
    
    func setupAddButtonTarget() {
        let targetsEmpty = addButton.actions(forTarget: router, forControlEvent: .touchUpInside)?.isEmpty ?? true
        if targetsEmpty == true {
            addButton.addTarget(router, action: #selector(router?.navigateToNewEntry), for: .touchUpInside)
        }
    }
}
