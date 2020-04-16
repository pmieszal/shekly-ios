//
//  InteractorLogic.swift
//  CleanArchitectureHelpers
//
//  Created by Patryk Mieszała on 16/04/2020.
//

@objc
public protocol InteractorLogic: AnyObject {
    @objc optional func viewDidLoad()
    @objc optional func viewDidAppear()
    @objc optional func viewWillAppear()
    @objc optional func viewDidDisappear()
    @objc optional func viewWillDisappear()
}
