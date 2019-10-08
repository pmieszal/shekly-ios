//
//  UIView+Rx.swift
//  UI
//
//  Created by Patryk Mieszała on 08/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    func isHiddenAnimate(duration: TimeInterval = 0.3) -> Binder<Bool> {
        return Binder(base) { (view, isHidden) in
            if isHidden == false && view.alpha == 0 {
                view.isHidden = false
            }
            
            UIView
                .animate(
                    withDuration: duration,
                    animations: {
                        view.alpha = isHidden ? 0 : 1
                },
                    completion: { _ in
                        view.isHidden = isHidden
                })
        }
    }
}
