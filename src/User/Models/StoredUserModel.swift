//
//  StoredUserModel.swift
//  User
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

class StoredUserModel: Codable {
    
    var accessToken: String?
    var refreshToken: String?
    
    var selectedWalletId: String?
    
    static func restore(withKey key: String) -> StoredUserModel {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let user = try? JSONDecoder().decode(StoredUserModel.self, from: data)
            else {
                return StoredUserModel()
        }
        
        return user
    }
}
