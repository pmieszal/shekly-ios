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
import RxSwift
import RxCocoa

protocol SheklyMonthCollectionViewDelegate: class {
    func monthCollectionViewDidScroll(toDate date: Date)
}

class SheklyMonthCollectionView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
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
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    @discardableResult
    private
    func decideCollectionViewPosition(scroll: Bool = true) -> IndexPath? {
        let visibleCells: [UICollectionViewCell] = collectionView.visibleCells
        
        let sorted = visibleCells
            .sorted { left, right -> Bool in
                
                let centerLeft = self.convert(left.center, from: collectionView)
                let centerRight = self.convert(right.center, from: collectionView)
                
                let leftDiff = abs(self.center.x - centerLeft.x)
                let rightDiff = abs(self.center.x - centerRight.x)
                
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

private extension SheklyMonthCollectionView {
    
    func setup() {
        collectionView.register(R.nib.sheklyMonthCell)
        
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView
            .rx
            .setDataSource(self)
            .disposed(by: disposeBag)
        
        let willDisplayCell = collectionView
            .rx
            .willDisplayCell
            .asObservable()
            .debounce(.milliseconds(10), scheduler: MainScheduler.instance)
            .take(1)
        
        willDisplayCell
            .subscribe(onNext: { [weak self] (event) in
                guard let self = self else { return }
                
                if let index = self.dates.firstIndex(where: { $0.isInside(date: Date(), granularity: .month) }) {
                    let indexPath = IndexPath(item: index, section: 0)
                    
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                }
            })
            .disposed(by: disposeBag)
        
        willDisplayCell
            .delay(.milliseconds(10), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (event) in
                guard let self = self else { return }
                
                self.scrollViewDidScroll(self.collectionView)
            })
            .disposed(by: disposeBag)
        
        let didEndScrollingAnimation: Signal<Void> = collectionView
            .rx
            .didEndScrollingAnimation
            .asSignal()
        
        let didEndDecelerating: Signal<Void> = collectionView
            .rx
            .didEndDecelerating
            .asSignal()
        
        Signal
            .merge(didEndScrollingAnimation, didEndDecelerating)
            .map { [weak self] _ -> Date? in
                guard let indexPath = self?.decideCollectionViewPosition(scroll: false) else { return nil }
                
                return self?.dates[indexPath.row]
            }
            .filterNil()
            .distinctUntilChanged()
            .emit(onNext: { [weak self] (date) in
                self?.delegate?.monthCollectionViewDidScroll(toDate: date)
            })
            .disposed(by: disposeBag)
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
        
        cell.date = self.dates[indexPath.row]
        
        return cell
    }
    
}

extension SheklyMonthCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells: [SheklyMonthCell] = collectionView.visibleCells as? [SheklyMonthCell] ?? []
        
        visibleCells
            .forEach { (cell) in
                let center = self.convert(cell.center, from: scrollView)
                cell.updateLayout(forCenter: center, parentSize: scrollView.frame.size)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.decideCollectionViewPosition()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.decideCollectionViewPosition()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            self.decideCollectionViewPosition()
        }
    }
}

extension SheklyMonthCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return SheklyMonthCell.size(forDate: dates[indexPath.row], inCollectionView: collectionView)
    }
}
