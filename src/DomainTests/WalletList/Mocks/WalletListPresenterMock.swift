//
//  WalletListPresenterMock.swift
//  DomainTests
//
//  Created by Patryk Mieszała on 20/11/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Domain

class WalletListPresenterMock: WalletListPresenter {
    var reloadListHandler: (() -> ())?
    
    func reloadList() {
        reloadListHandler?()
    }
}
