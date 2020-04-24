import Foundation

public class SheklyJSONImporter {
    let decoder: JSONDecoder = {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        return decoder
    }()
    
    let dataController: SheklyJSONDataController
    
    init(dataController: SheklyJSONDataController) {
        self.dataController = dataController
    }
    
    public func importData(fromJSONUrl url: URL, completionHandler: () -> Void) {
        do {
            let jsonData: Data = try Data(contentsOf: url)
            let wallet: WalletJSONModel = try decoder.decode(WalletJSONModel.self, from: jsonData)
            
            dataController.save(wallet: wallet, completionHandler: completionHandler)
        } catch {
            print(error)
        }
    }
}
