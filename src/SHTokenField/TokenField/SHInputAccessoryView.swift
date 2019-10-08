//
//  SHInputAccessoryView.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 06/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

class SHInputAccessoryView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fill
        stackView.spacing = 5
        
        return stackView
    }()
    
    func setup() {
        
        let scrollView = self.scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        self.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        let suggestions = self.stackView
        suggestions.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(suggestions)
        
        suggestions.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        suggestions.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        suggestions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        suggestions.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        suggestions.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
}
