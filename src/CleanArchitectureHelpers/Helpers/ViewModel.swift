//
//  ViewModel.swift
//  Domain
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

@available(*, deprecated, message: "Delete this")
public protocol ViewModel: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidAppear()
    func viewDidDisappear()
}

public extension ViewModel {
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewWillDisappear() { }
    func viewDidAppear() { }
    func viewDidDisappear() { }
}
