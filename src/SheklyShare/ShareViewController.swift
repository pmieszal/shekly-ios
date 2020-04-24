import MobileCoreServices
import Social
import UIKit

import Common
import Database

class ShareViewController: SLComposeServiceViewController {
    private var fileUrl: URL?
    
    private let importer: SheklyJSONImporter = DependencyContainer().configureDatabase().forceResolve()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let extensionItem = extensionContext?.inputItems[0] as? NSExtensionItem else {
            return
        }
        
        let contentTypeURL = kUTTypeURL as String
        
        for attachment in extensionItem.attachments! {
            attachment.loadItem(forTypeIdentifier: contentTypeURL, options: nil) { [weak self] results, _ in
                if let url = results as? URL {
                    self?.fileUrl = url
                }
                
                self?.didSelectPost()
            }
        }
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        // Inform the host that we're done, so it un-blocks its UI.
        // Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        if let fileUrl = fileUrl {
            importer.importData(fromJSONUrl: fileUrl) { [weak self] in
                self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            }
        } else {
            extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
}
