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

protocol SheklyMonthCollectionViewDelegate: class {
    func monthCollectionViewDidScroll(toDate date: Date)
}

class SheklyMonthCollectionView: UIView {
    
    private lazy var collectionView: UICollectionView = {
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
    
    private lazy var dates: [Date] = {
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
    
    weak var delegate: SheklyMonthCollectionViewDelegate?
    var didMadeInitialLayout = false
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

extension SheklyMonthCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SheklyMonthCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.sheklyMonthCell, for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.date = dates[indexPath.row]
        
        return cell
    }
    
}

extension SheklyMonthCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return SheklyMonthCell.size(forDate: dates[indexPath.row], inCollectionView: collectionView)
    }
}

extension SheklyMonthCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells: [SheklyMonthCell] = collectionView.visibleCells as? [SheklyMonthCell] ?? []
        
        visibleCells
            .forEach { (cell) in
                let center = convert(cell.center, from: scrollView)
                cell.updateLayout(forCenter: center, parentSize: scrollView.frame.size)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = decideCollectionViewPosition() else {
            return
        }
        
        let date = dates[indexPath.row]
        delegate?.monthCollectionViewDidScroll(toDate: date)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let indexPath = decideCollectionViewPosition() else {
            return
        }
        
        let date = dates[indexPath.row]
        delegate?.monthCollectionViewDidScroll(toDate: date)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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
            else { return nil }
        
        if scroll == true {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        return indexPath
    }
}
