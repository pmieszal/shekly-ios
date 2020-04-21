//
//  SetSessionWalletUseCase.swift
//  Domain
//
//  Created by Patryk Mieszała on 21/04/2020.
//

import Foundation

public final class SetSessionWalletUseCase {
    let session: SessionRepository
    
    init(session: SessionRepository) {
        self.session = session
    }
}

public extension SetSessionWalletUseCase {
    func set(walletId: String?) {
        session.set(walletId: walletId)
    }
}
