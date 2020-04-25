import Common
import CommonUI
import Domain
import UIKit

class WalletHeaderView: UIView {
    private lazy var monthView: WalletMonthCollectionView = {
        let view = WalletMonthCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        return view
        
    }()
    
    weak var monthCollectionDelegate: WalletMonthCollectionViewDelegate? {
        get {
            return monthView.delegate
        }
        set {
            monthView.delegate = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

private extension WalletHeaderView {
    func setup() {
        backgroundColor = .systemBackground
        layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2
        layer.shadowOffset = .zero
    }
}
