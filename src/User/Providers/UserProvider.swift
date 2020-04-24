import Common
import Domain

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

class UserProvider {
    private enum Keys {
        static let user: String = "shekly::user"
    }
    
    private var user: StoredUserModel = {
        StoredUserModel.restore(withKey: Keys.user)
    }() {
        didSet {
            do {
                let data = try JSONEncoder().encode(user)
                UserDefaults.standard.set(data, forKey: Keys.user)
                log.info("Saving stored user")
                log.debug(user.toJSONString())
            } catch {
                log.error(error)
            }
        }
    }
    
    var token: String? {
        return user.accessToken
    }
    
    init() {}
}

extension UserProvider: SessionRepository {
    var selectedWalletId: String? {
        return user.selectedWalletId
    }
    
    func set(walletId: String?) {
        user.selectedWalletId = walletId
        save()
    }
}

private extension UserProvider {
    func save() {
        let tmp = user
        user = tmp
    }
}
