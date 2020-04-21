//
//  DBWalletWorker.swift
//  Database
//
//  Created by Patryk Mieszała on 19/04/2020.
//

import Domain

class DBWalletWorker: DBGroup<DBWalletModel> {
    func save(wallet: DBWalletModel) {
        save(object: wallet)
    }
}

extension DBWalletWorker: WalletRepository {
    func getWallets() -> [WalletModel] {
        let wallets = list()
        
        return wallets.map(WalletModel.init)
    }
    
    func getWallet(id: String) -> WalletModel? {
        guard let object = get(id: id) else {
            return nil
        }
        
        return WalletModel(object)
    }
    
    func save(wallet: WalletModel) -> WalletModel {
        let model = DBWalletModel(wallet)
        save(object: model)
        
        return WalletModel(model)
    }
}
