//
//  GetWalletEntriesUseCase.swift
//  Domain
//
//  Created by Patryk Mieszała on 21/04/2020.
//

import Foundation

public final class GetWalletEntriesUseCase {
    enum UseCaseError: SheklyError {
        case walletIdNil
    }
    
    let repository: WalletEntriesRepository
    
    init(repository: WalletEntriesRepository) {
        self.repository = repository
    }
}

public extension GetWalletEntriesUseCase {
    func getEntries(wallet: WalletModel,
                    monthDate: Date,
                    success: (([WalletEntryModel]) -> Void)?,
                    failure: ((SheklyError) -> Void)?) {
        guard let walletId = wallet.id else {
            failure?(UseCaseError.walletIdNil)
            return
        }
        
        let entries = repository.getWalletEntries(
            forWalletId: walletId,
            monthDate: monthDate)
            .sorted()
        
        success?(entries)
    }
}
