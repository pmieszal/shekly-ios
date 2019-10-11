//
//  TabCoordinator.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain
import User
import Shared

final class TabCoordinator: RxCoordinator {
    weak var tabController: SheklyTabBarController!
    weak var newEntryVC: NewEntryViewController?
    
    let userFactory: UserFactory
    let viewModelFactory: DomainFactory
    
    init(parent: RxCoordinator, userFactory: UserFactory, viewModelFactory: DomainFactory) {
        self.userFactory = userFactory
        self.viewModelFactory = viewModelFactory
        
        super.init(parent: parent)
    }
    
    @discardableResult
    override func start() -> UIViewController? {
        let tabController: SheklyTabBarController = SheklyTabBarController(router: self)
        
        let walletCoordinator = WalletCoordinator(parent: self, userFactory: userFactory, viewModelFactory: viewModelFactory)
        guard let wallet = walletCoordinator.start() else {
            fatalError("VC can't be nil")
        }
        wallet.tabBarItem.title = "Portfel"
        wallet.tabBarItem.image = R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysOriginal)
        wallet.tabBarItem.selectedImage = R.image.tabBarWalletIcon()
        
        let planCoordinator = PlanCoordinator(parent: self, userFactory: userFactory, viewModelFactory: viewModelFactory)
        guard let plan = planCoordinator.start() else {
            fatalError("VC can't be nil")
        }
        plan.tabBarItem.title = "Plan"
        plan.tabBarItem.image = R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysOriginal)
        plan.tabBarItem.selectedImage = R.image.tabBarPlanIcon()
        
        class TempViewController: SheklyViewController<SheklyViewModel> { }
        
        let stats = TempViewController()
        stats.set(viewModel: self.viewModelFactory.getEmptyViewModel())
        stats.view.backgroundColor = Colors.brandColor
        stats.tabBarItem.title = "Statystyki"
        stats.tabBarItem.image = R.image.tabBarStatsIcon()?.withRenderingMode(.alwaysOriginal)
        stats.tabBarItem.selectedImage = R.image.tabBarStatsIcon()
        
        let more = TempViewController()
        more.set(viewModel: self.viewModelFactory.getEmptyViewModel())
        more.view.backgroundColor = Colors.brandColor
        more.tabBarItem.title = "Więcej"
        more.tabBarItem.image = R.image.tabBarMoreIcon()?.withRenderingMode(.alwaysOriginal)
        more.tabBarItem.selectedImage = R.image.tabBarMoreIcon()
        
        let empty = UIViewController()
        
        tabController.setViewControllers([wallet, plan, empty, stats, more], animated: false)
        
        self.tabController = tabController
        
        return tabController
    }
}

extension TabCoordinator {
    @objc
    func navigateToNewEntry() {
        guard let newEntryVC: NewEntryViewController = R.storyboard.newEntry.newEntryViewController() else {
            fatalError("VC can't be nil")
        }
        newEntryVC.set(viewModel: self.viewModelFactory.getNewEntryViewModel(presenter: newEntryVC))
        newEntryVC.router = self
        
        self.newEntryVC = newEntryVC
        tabController.present(newEntryVC, animated: true, completion: nil)
    }
}

extension TabCoordinator: NewEntryRouter {
    func presentWalletListPopover(sourceButton: UIButton) {
        guard let delegate = newEntryVC?.viewModel else {
            return
        }
        
        let walletList = R.storyboard.walletList.walletListViewController()!
        let viewModel = viewModelFactory.getWalletListViewModel(presenter: walletList, delegate: delegate)
        walletList.set(viewModel: viewModel)
        
        newEntryVC?.presentAsPopover(vc: walletList, sourceView: sourceButton, preferredContentSize: CGSize(width: 200, height: 300))
    }
    
    func presentDatePickerPopover(sourceButton: UIButton) {
        guard let delegate = newEntryVC?.viewModel else {
            return
        }
        
        let datePicker = R.storyboard.datePicker.datePickerViewController()!
        let viewModel = viewModelFactory.getDatePickerViewModel(delegate: delegate)
        datePicker.set(viewModel: viewModel)
        
        let screenWidth = UIScreen.main.bounds.width
        let preferredContentSize = CGSize(width: screenWidth - 20, height: 270)
        
        newEntryVC?.presentAsPopover(vc: datePicker, sourceView: sourceButton, preferredContentSize: preferredContentSize)
    }
}
