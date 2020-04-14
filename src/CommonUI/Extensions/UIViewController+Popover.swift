//
//  UIViewController+Popover.swift
//  UI
//
//  Created by Patryk Mieszała on 07/04/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

public extension UIViewController {
    func presentAsPopover(vc: UIViewController, sourceView: UIView, preferredContentSize: CGSize = CGSize(width: 200, height: 100)) {
        vc.preferredContentSize = preferredContentSize
        vc.modalPresentationStyle = .popover
        
        let popover = vc.popoverPresentationController
        popover?.delegate = self
        popover?.sourceView = sourceView
        popover?.sourceRect = sourceView.frame
        popover?.sourceRect.origin.x = 0
        popover?.sourceRect.origin.y += 5
        popover?.permittedArrowDirections = .up
        popover?.canOverlapSourceViewRect = false
        
        present(vc, animated: true, completion: nil)
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
