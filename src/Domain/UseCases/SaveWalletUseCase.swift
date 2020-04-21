//
//  SaveWalletUseCase.swift
//  Domain
//
//  Created by Patryk Mieszała on 21/04/2020.
//

import Foundation

public final class SaveWalletUseCase {
    let repository: WalletRepository
    
    init(repository: WalletRepository) {
        self.repository = repository
    }
}

public extension SaveWalletUseCase {
    func save(wallet: WalletModel,
              success: ((WalletModel) -> Void)?,
              failure: ((SheklyError) -> Void)?) {
        let saved = repository.save(wallet: wallet)
        success?(saved)
    }
}
