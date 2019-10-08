//
//  ShareViewController.swift
//  SheklyShare
//
//  Created by Patryk Mieszała on 02/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

import Database

class ShareViewController: SLComposeServiceViewController {
    
    private var fileUrl: URL?
    
    private let importer = DatabaseFactory().getSheklyJSONImporter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let extensionItem = extensionContext?.inputItems[0] as! NSExtensionItem
        let contentTypeURL = kUTTypeURL as String
        
        for attachment in extensionItem.attachments! {
            attachment
                .loadItem(forTypeIdentifier: contentTypeURL, options: nil) { (results, error) in
                    
                    if let url = results as? URL {
                        self.fileUrl = url
                    }
                    
                    self.didSelectPost()
                }
        }
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        if let fileUrl = self.fileUrl {
            importer.importData(fromJSONUrl: fileUrl) { [weak self] in
                self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            }
        }
        else {
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
