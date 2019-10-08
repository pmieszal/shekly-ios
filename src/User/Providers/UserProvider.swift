//
//  UserProvider.swift
//  User
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftDate
import Shared

class UserProvider: UserManaging {
    
    private struct Keys {
        static let user: String = "shekly::user"
    }
    
    private var user: StoredUserModel = {
        return StoredUserModel.restore(withKey: Keys.user)
    }()
    {
        didSet {
            do {
                let data = try JSONEncoder().encode(user)
                UserDefaults.standard.set(data, forKey: Keys.user)
                log.info("Saving stored user")
                log.debug(user.toJSONString() ?? "Error when decoding to string")
            }
            catch let error {
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
    
    let shouldShowLogin: Signal<Void>
    private let shouldShowLoginRelay: PublishRelay<Void> = .init()
    
    static let shared: UserManaging = UserProvider()
    
    private init() {
        self.shouldShowLogin = self.shouldShowLoginRelay.asSignal()
    }
    
    func logout() {
        self.user = StoredUserModel()
        self.shouldShowLoginRelay.accept(())
    }
    
    func set(wallet id: String?) {
        self.user.selectedWalletId = id
        
        save()
    }
}
    
private extension UserProvider {
    func save() {
        let tmp = user
        
        self.user = tmp
    }
}
