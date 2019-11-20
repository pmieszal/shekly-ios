//
//  WalletListTests.swift
//  DomainTests
//
//  Created by Patryk Mieszała on 20/11/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import XCTest

@testable import Domain
import Database

class WalletListTests: XCTestCase {
    
    var sut: WalletListViewModel!
    var presenter: WalletListPresenterMock!
    var delegate: WalletListDelegateMock!
    var dataController: SheklyDataControllerMock!

    override func setUp() {
        presenter = WalletListPresenterMock()
        delegate = WalletListDelegateMock()
        dataController = SheklyDataControllerMock()
        sut = WalletListViewModel(presenter: presenter, delegate: delegate, dataController: dataController)
    }

    override func tearDown() {
        presenter = nil
        delegate = nil
        dataController = nil
        sut = nil
    }

    func testReloadListOnViewDidLoad() {
        let promise = expectation(description: "Reload list invoked")
        
        presenter.reloadListHandler = { promise.fulfill() }
        sut.viewDidLoad()
        
        wait(for: [promise], timeout: 1)
        
        let numberOfSections = sut.numberOfSections()
        let numberOfRows = sut.numberOfRows(inSection: 0)
        
        let wallets = dataController.getWallets()
        
        XCTAssert(numberOfSections == 1)
        XCTAssert(numberOfRows == wallets.count)
    }
    
    func testDidSelectWallet() {
        let promise = expectation(description: "Did select wallet invoked")
        var selectedWallet: WalletModel?
        
        delegate.didSelectHandler = { wallet in
            selectedWallet = wallet
            promise.fulfill()
        }
        
        let wallet = WalletModel(name: "Test", properties: nil)
        
        dataController.wallets = [wallet]
        
        sut.viewDidLoad()
        sut.didSelect(itemAt: IndexPath(item: 0, section: 0))
        
        wait(for: [promise], timeout: 1)
        
        XCTAssert(selectedWallet?.name == wallet.name)
    }
}
