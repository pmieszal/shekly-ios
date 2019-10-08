//
//  SheklyJSONImporter.swift
//  Database
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

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
    
    public func importData(fromJSONUrl url: URL, completionHandler: () -> ()) {
        do {
            let jsonData: Data = try Data(contentsOf: url)
            let wallet: WalletJSONModel = try self.decoder.decode(WalletJSONModel.self, from: jsonData)
            
            self.dataController.save(wallet: wallet, completionHandler: completionHandler)
        }
        catch let error {
            print(error)
        }
    }
}
