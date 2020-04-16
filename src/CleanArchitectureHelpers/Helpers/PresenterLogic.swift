//
//  PresenterLogic.swift
//  CleanArchitectureHelpers
//
//  Created by Patryk Mieszała on 16/04/2020.
//

import UIKit

public protocol PresenterLogic: AnyObject {
    var viewControllerLogic: ViewControllerLogic? { get }
    func show(error: Error)
}

public extension PresenterLogic {
    func show(error: Error) {
        viewControllerLogic?.show(error: error)
    }
    
    func hapticSelection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    func hapticSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
