//
//  NewEntryCellModel.swift
//  NewEntry
//
//  Created by Patryk Mieszała on 23/04/2020.
//

import Foundation
import Domain

protocol NewEntryCellModel: Hashable {
    var id: String? { get }
    var name: String { get }
}

extension CategoryModel: NewEntryCellModel {}
extension SubcategoryModel: NewEntryCellModel {}
