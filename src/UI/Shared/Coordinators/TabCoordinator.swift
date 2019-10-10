//
//  TabCoordinator.swift
//  UI
//
//  Created by Patryk Mieszała on 14/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import Domain
import User
import Shared

public final class TabCoordinator: RxCoordinator {
    
    private weak var tabController: SheklyTabBarController!
    private weak var newEntryVC: NewEntryViewController?
    
    private let userFactory: UserFactory
    private let viewModelFactory: DomainFactory
    
    public init(parent: RxCoordinator, userFactory: UserFactory, viewModelFactory: DomainFactory) {
        self.userFactory = userFactory
        self.viewModelFactory = viewModelFactory
        
        super.init(parent: parent)
    }
    
    @discardableResult
    override public func start() -> UIViewController? {
        let tabController: SheklyTabBarController = SheklyTabBarController()
        
        //TODO: get rid of callbacks, user presenter + router
        tabController
            .rx
            .onAddEntryTap
            .emit(onNext: { [weak self] in
                self?.navigateToNewEntry()
            })
            .disposed(by: disposeBag)
        
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
        stats.set(viewModel: self.viewModelFactory.getEmptyViewModel(disposeBag: stats.disposeBag))
        stats.view.backgroundColor = Colors.brandColor
        stats.tabBarItem.title = "Statystyki"
        stats.tabBarItem.image = R.image.tabBarStatsIcon()?.withRenderingMode(.alwaysOriginal)
        stats.tabBarItem.selectedImage = R.image.tabBarStatsIcon()
        
        let more = TempViewController()
        more.set(viewModel: self.viewModelFactory.getEmptyViewModel(disposeBag: more.disposeBag))
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

private extension TabCoordinator {
    
    func navigateToNewEntry() {
        guard let newEntryVC: NewEntryViewController = R.storyboard.newEntry.newEntryViewController() else {
            fatalError("VC can't be nil")
        }
        newEntryVC.set(viewModel: self.viewModelFactory.getNewEntryViewModel(presenter: newEntryVC, disposeBag: newEntryVC.disposeBag))
        newEntryVC.router = self
        
        self.newEntryVC = newEntryVC
        self.tabController.present(newEntryVC, animated: true, completion: nil)
    }
}

extension TabCoordinator: NewEntryRouter {
    func presentWalletListPopover(sourceButton: UIButton) {
        guard let delegate = self.newEntryVC?.viewModel else { return }
        
        let walletList = R.storyboard.walletList.walletListViewController()!
        let viewModel = viewModelFactory.getWalletListViewModel(presenter: walletList, delegate: delegate, disposeBag: disposeBag)
        walletList.set(viewModel: viewModel)
        
        newEntryVC?.presentAsPopover(vc: walletList, sourceView: sourceButton, preferredContentSize: CGSize(width: 200, height: 300))
    }
    
    func presentDatePickerPopover(sourceButton: UIButton) {
        guard let delegate = self.newEntryVC?.viewModel else { return }
        
        let datePicker = R.storyboard.datePicker.datePickerViewController()!
        let viewModel = viewModelFactory.getDatePickerViewModel(delegate: delegate)
        datePicker.set(viewModel: viewModel)
        
        let screenWidth = UIScreen.main.bounds.width
        let preferredContentSize = CGSize(width: screenWidth - 20, height: 270)
        
        newEntryVC?.presentAsPopover(vc: datePicker, sourceView: sourceButton, preferredContentSize: preferredContentSize)
    }
}
