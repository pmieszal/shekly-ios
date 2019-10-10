//
//  Differ.swift
//  Domain
//
//  Created by Patryk Mieszała on 22/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import Foundation

class Differ {
    
    func getDiff<T: Hashable & Equatable>(oldState: [T], newState: [T]) -> ChangeSet {
        
        let oldStateWithIndexSet: Set<State<T>> = Set(
            oldState
                .enumerated()
                .map { State(row: $0.offset, section: 0, element: $0.element) }
        )
        let newStateWithIndexSet: Set<State<T>> = Set(
            newState
                .enumerated()
                .map { State(row: $0.offset, section: 0, element: $0.element) }
        )
        
        let inserted = newStateWithIndexSet.subtracting(oldStateWithIndexSet)
        let deleted = oldStateWithIndexSet.subtracting(newStateWithIndexSet)
        let updated = oldStateWithIndexSet.intersection(newStateWithIndexSet)
        
        let insertedIndexPaths: [IndexPath] = inserted.map { IndexPath(row: $0.row, section: $0.section) }
        let deletedIndexPaths: [IndexPath] = deleted.map { IndexPath(row: $0.row, section: $0.section) }
        
        var updatedIndexPaths: [IndexPath] = []
        var movedIndexPaths: [(from: IndexPath, to: IndexPath)] = []
        
        for updatedItem in updated {
            guard let oldItemIndex = oldState.firstIndex(of: updatedItem.element),
                let newItemIndex = newState.firstIndex(of: updatedItem.element)
                else {
                    break
            }
            
            if oldItemIndex == newItemIndex {
                updatedIndexPaths.append(IndexPath(row: newItemIndex, section: 0))
            } else {
                let from = IndexPath(row: oldItemIndex, section: 0)
                let to = IndexPath(row: newItemIndex, section: 0)
                
                movedIndexPaths.append((from: from, to: to))
            }
        }
        
        return ChangeSet(inserted: insertedIndexPaths, deleted: deletedIndexPaths, moved: movedIndexPaths, updated: updatedIndexPaths)
    }
    
    func getDiff<T: Hashable & Equatable>(oldState: [[T]], newState: [[T]]) -> ChangeSet {
        
        let oldStateWithIndexSet: Set<State<T>> = Set(
            oldState
                .enumerated()
                .map { section in
                    return section
                        .element
                        .enumerated()
                        .map { State(row: $0.offset, section: section.offset, element: $0.element) }
                }
                .joined()
                .compactMap { $0 }
        )
        let newStateWithIndexSet: Set<State<T>> = Set(
            newState
                .enumerated()
                .map { section in
                    return section
                        .element
                        .enumerated()
                        .map { State(row: $0.offset, section: section.offset, element: $0.element) }
                }
                .joined()
                .compactMap { $0 }
        )
        
        let inserted = newStateWithIndexSet.subtracting(oldStateWithIndexSet)
        let deleted = oldStateWithIndexSet.subtracting(newStateWithIndexSet)
        let updated = oldStateWithIndexSet.intersection(newStateWithIndexSet)
        
        let insertedIndexPaths: [IndexPath] = inserted.map { IndexPath(row: $0.row, section: $0.section) }
        let deletedIndexPaths: [IndexPath] = deleted.map { IndexPath(row: $0.row, section: $0.section) }
        
        var updatedIndexPaths: [IndexPath] = []
        var movedIndexPaths: [(from: IndexPath, to: IndexPath)] = []
        
        for updatedItem in updated {
            guard let oldItemIndex = oldState[updatedItem.section].firstIndex(of: updatedItem.element),
                let newItemIndex = newState[updatedItem.section].firstIndex(of: updatedItem.element)
                else {
                    break
            }
            
            if oldItemIndex == newItemIndex {
                updatedIndexPaths.append(IndexPath(row: newItemIndex, section: 0))
            } else {
                let from = IndexPath(row: oldItemIndex, section: 0)
                let to = IndexPath(row: newItemIndex, section: 0)
                
                movedIndexPaths.append((from: from, to: to))
            }
        }
        
        return ChangeSet(inserted: insertedIndexPaths, deleted: deletedIndexPaths, moved: movedIndexPaths, updated: updatedIndexPaths)
    }
}

struct State<T: Hashable>: Equatable, Hashable {
    
    let row: Int
    let section: Int
    let element: T
    
    static func == (lhs: State<T>, rhs: State<T>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(element.hashValue)
    }
}

public struct ChangeSet {
    
    public let inserted: [IndexPath]
    public let deleted: [IndexPath]
    public let moved: [(from: IndexPath, to: IndexPath)]
    public let updated: [IndexPath]
}
