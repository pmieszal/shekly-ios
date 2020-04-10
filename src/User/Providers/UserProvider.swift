//
//  UserProvider.swift
//  User
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Combine
import SwiftDate
import Common

extension Encodable {
    func toJSONString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(self),
            let jsonString = String(data: data, encoding: .utf8)
            else {
                fatalError("Fix your data")
        }
        
        return jsonString
    }
}

class UserProvider: UserManaging {
    
    private enum Keys {
        static let user: String = "shekly::user"
    }
    
    private var user: StoredUserModel = {
        return StoredUserModel.restore(withKey: Keys.user)
    }() {
        didSet {
            do {
                let data = try JSONEncoder().encode(user)
                UserDefaults.standard.set(data, forKey: Keys.user)
                log.info("Saving stored user")
                log.debug(user.toJSONString())
            } catch let error {
                log.error(error)
            }
        }
    }
    
    var token: String? {
        return user.accessToken
    }
    
    var selectedWalletId: String? {
        return user.selectedWalletId
    }
    
    init() { }
    
    func set(wallet id: String?) {
        user.selectedWalletId = id
        save()
    }
}
    
private extension UserProvider {
    func save() {
        let tmp = user
        user = tmp
    }
}
