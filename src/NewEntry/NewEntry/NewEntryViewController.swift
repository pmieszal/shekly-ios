import CleanArchitectureHelpers
import Common
import CommonUI
import Domain
import UIKit

protocol NewEntryViewControllerLogic: ViewControllerLogic {
    typealias CategorySnapshot = NSDiffableDataSourceSnapshot<String, CategoryModel>
    typealias SubcategorySnapshot = NSDiffableDataSourceSnapshot<String, SubcategoryModel>
    
    func show(walletName: String?)
    func show(date: String?)
    func show(amount: String, color: UIColor)
    func setSaveButton(enabled: Bool)
    func reloadCategories(snapshot: CategorySnapshot)
    func reloadSubcategories(snapshot: SubcategorySnapshot)
    func dismiss()
}

final class NewEntryViewController: SheklyViewController {
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var entryTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet private weak var amountTextField: UITextField!
    
    @IBOutlet private weak var walletButton: UIButton!
    @IBOutlet private weak var dateButton: UIButton!
    
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var categoryCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var subcategoryHeader: UIView!
    @IBOutlet private weak var subcategoriesContainer: UIView!
    @IBOutlet private weak var subcategoryCollectionView: UICollectionView!
    @IBOutlet private weak var subcategoryCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var saveButton: UIButton!
    
    lazy var categoryDataSource = NewEntryCollectionDataSource<CategoryModel>(collectionView: categoryCollectionView)
    // swiftlint:disable:next weak_delegate
    lazy var categoryDelegate = NewEntryCollectionDelegate(
        dataSource: categoryDataSource,
        didSelectItem: interactor?.didSelectCategory(id:))
    
    lazy var subcategoryDataSource = NewEntryCollectionDataSource<SubcategoryModel>(
        collectionView: subcategoryCollectionView)
    // swiftlint:disable:next weak_delegate
    lazy var subcategoryDelegate = NewEntryCollectionDelegate(
        dataSource: subcategoryDataSource,
        didSelectItem: interactor?.didSelectSubcategory(id:))
    
    var interactor: NewEntryInteractorLogic?
    var router: NewEntryRouterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        interactor?.viewDidLoad?()
        amountTextField.becomeFirstResponder()
    }
}

extension NewEntryViewController: NewEntryViewControllerLogic {
    func show(walletName: String?) {
        walletButton.setTitle(walletName, for: .normal)
    }
    
    func show(date: String?) {
        dateButton.setTitle(date, for: .normal)
    }
    
    func show(amount: String, color: UIColor) {
        amountTextField.text = amount
        amountTextField.textColor = color
    }
    
    func setSaveButton(enabled: Bool) {
        saveButton.isEnabled = enabled
    }
    
    func reloadCategories(snapshot: CategorySnapshot) {
        categoryDataSource.apply(
            snapshot,
            completion: {
                self.categoryCollectionViewHeight.constant = self.categoryCollectionView.contentSize.height
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
        })
    }
    
    func reloadSubcategories(snapshot: SubcategorySnapshot) {
        UIView.animate(withDuration: 0.2) {
            self.subcategoryHeader.isHidden = false
            self.subcategoriesContainer.isHidden = false
        }
        
        subcategoryDataSource.apply(
            snapshot,
            animatingDifferences: false,
            completion: {
                self.subcategoryCollectionViewHeight.constant = self.subcategoryCollectionView.contentSize.height
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
        })
    }
    
    func dismiss() {
        router?.dismiss()
    }
}

extension NewEntryViewController: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return interactor?.amountTextField(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
}

extension NewEntryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        interactor?.commentTextViewDidChange(textView.text)
    }
}

private extension NewEntryViewController {
    func setup() {
        view.backgroundColor = Colors.brandColor
        
        subcategoryHeader.isHidden = true
        subcategoriesContainer.isHidden = true
        
        walletButton.setImage(
            CommonUI.R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysTemplate),
            for: .normal)
        walletButton.addTarget(
            router,
            action: #selector(router?.presentWalletListPopover(sourceButton:)),
            for: .touchUpInside)
        dateButton.setImage(
            CommonUI.R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysTemplate),
            for: .normal)
        dateButton.addTarget(
            router,
            action: #selector(router?.presentDatePickerPopover(sourceButton:)),
            for: .touchUpInside)
        
        entryTypeSegmentedControl.addTarget(
            self,
            action: #selector(didChangeSegmentedControl),
            for: UIControl.Event.valueChanged)
        
        saveButton.addTarget(
            interactor, action:
            #selector(interactor?.save),
            for: .touchUpInside)
        
        amountTextField.delegate = self
        commentTextView.delegate = self
        
        categoryCollectionView.delegate = categoryDelegate
        categoryCollectionView.setCollectionViewLayout(NewEntryCollectionLayout.layout(), animated: false)
        
        subcategoryCollectionView.delegate = subcategoryDelegate
        subcategoryCollectionView.setCollectionViewLayout(NewEntryCollectionLayout.layout(), animated: false)
        
        commentTextView.layer.cornerRadius = 4
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.white.cgColor
        commentTextView.clipsToBounds = true
        
        entryTypeSegmentedControl
            .setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                ],
                for: .normal)
        
        cancelButton.addTarget(
            router,
            action: #selector(router?.dismiss),
            for: .touchUpInside)
    }
    
    @objc
    func didChangeSegmentedControl() {
        interactor?.didSelectSegmentedControl(itemAtIndex: entryTypeSegmentedControl.selectedSegmentIndex)
    }
}
