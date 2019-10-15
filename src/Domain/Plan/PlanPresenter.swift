//
//  PlanPresenter.swift
//  Domain
//
//  Created by Patryk Mieszała on 15/10/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

public protocol PlanPresenter: AnyObject {
    func navigate(to category: SheklyCategoryModel)
}
