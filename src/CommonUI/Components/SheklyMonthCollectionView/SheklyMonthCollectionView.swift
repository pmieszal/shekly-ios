//
//  SheklyMonthCollectionView.swift
//  UI
//
//  Created by Patryk Mieszała on 20/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import SwiftDate
import DynamicColor

public protocol SheklyMonthCollectionViewDelegate: AnyObject {
    func monthCollectionViewDidScroll(toDate date: Date)
}

public class SheklyMonthCollectionView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        return collectionView
    }()
    
    lazy var dates: [Date] = {
        let today = Date()
        let from = DateInRegion(year: today.year - 10, month: 1, day: 1)
        let to = DateInRegion(year: today.year + 10, month: 1, day: 1)
        let increment = DateComponents.create {
            $0.month = 1
        }
        
        let datesInRegion: [DateInRegion] = DateInRegion.enumerateDates(from: from, to: to, increment: increment)
        
        let dates: [Date] = datesInRegion.map { $0.date }
        
        return dates
    }()
    
    public weak var delegate: SheklyMonthCollectionViewDelegate?
    var didMadeInitialLayout = false
    
    convenience public init() {
        self.init(frame: .zero)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

extension SheklyMonthCollectionView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sheklyMonthCell,
                                                            for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.date = dates[indexPath.row]
        
        return cell
    }
    
}

extension SheklyMonthCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        guard didMadeInitialLayout == false else {
            return
        }
        
        didMadeInitialLayout = true
        
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.01) { [weak self] in
                if let index = self?.dates.firstIndex(where: { $0.isInside(date: Date(), granularity: .month) }) {
                    let indexPath = IndexPath(item: index, section: 0)
                    
                    self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                }
                
                DispatchQueue
                    .main
                    .asyncAfter(deadline: .now() + 0.01) { [weak self] in
                        self?.scrollViewDidScroll(collectionView)
                }
        }
    }
}

extension SheklyMonthCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SheklyMonthCell.size(forDate: dates[indexPath.row], inCollectionView: collectionView)
    }
}

extension SheklyMonthCollectionView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells: [SheklyMonthCell] = collectionView.visibleCells as? [SheklyMonthCell] ?? []
        
        visibleCells
            .forEach { (cell) in
                let center = convert(cell.center, from: scrollView)
                cell.updateLayout(forCenter: center, parentSize: scrollView.frame.size)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = decideCollectionViewPosition() else {
            return
        }
        
        let date = dates[indexPath.row]
        delegate?.monthCollectionViewDidScroll(toDate: date)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let indexPath = decideCollectionViewPosition() else {
            return
        }
        
        let date = dates[indexPath.row]
        delegate?.monthCollectionViewDidScroll(toDate: date)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            decideCollectionViewPosition()
        }
    }
}

private extension SheklyMonthCollectionView {
    func setup() {
        collectionView.register(R.nib.sheklyMonthCell)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @discardableResult
    func decideCollectionViewPosition(scroll: Bool = true) -> IndexPath? {
        let visibleCells: [UICollectionViewCell] = collectionView.visibleCells
        
        let sorted = visibleCells
            .sorted { left, right -> Bool in
                
                let centerLeft = convert(left.center, from: collectionView)
                let centerRight = convert(right.center, from: collectionView)
                
                let leftDiff = abs(center.x - centerLeft.x)
                let rightDiff = abs(center.x - centerRight.x)
                
                return leftDiff < rightDiff
        }
        
        guard let firstCell = sorted.first,
            let indexPath = collectionView.indexPath(for: firstCell)
            else {
            return nil
        }
        
        if scroll == true {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        return indexPath
    }
}
