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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let suggestions = stackView
        suggestions.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(suggestions)
        
        suggestions.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        suggestions.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        suggestions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        suggestions.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        suggestions.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
}
