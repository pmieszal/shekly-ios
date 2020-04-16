//
//  NewEntryViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 18/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

import CleanArchitectureHelpers
import CommonUI
import Common
import Domain

class NewEntryViewController: GenericSheklyViewController<NewEntryViewModel> {
    private enum Constants {
        static let cellWidthOffset: CGFloat = 30
        static let cellHeight: CGFloat = 27
    }
    
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var entryTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet private weak var amountTextField: UITextField!
    
    @IBOutlet private weak var walletButton: UIButton!
    @IBOutlet private weak var dateButton: UIButton!
    
    @IBOutlet private weak var categoryCollectionView1: UICollectionView!
    @IBOutlet private weak var categoryCollectionView2: UICollectionView!
    
    @IBOutlet private weak var subcategoryHeader: UIView!
    @IBOutlet private weak var subcategoriesContainer: UIView!
    @IBOutlet private weak var subcategoryCollectionView1: UICollectionView!
    @IBOutlet private weak var subcategoryCollectionView2: UICollectionView!
    
    @IBOutlet private weak var commentTextView: UITextView!
    @IBOutlet private weak var saveButton: UIButton!
    
    var router: NewEntryRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        amountTextField.becomeFirstResponder()
    }
}

extension NewEntryViewController: ReloadableViewController {
    var reloadableView: ReloadableView? {
        return nil
    }
}

extension NewEntryViewController: NewEntryPresenter {
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
    
    func reloadCategories(changeSet1: ChangeSet, changeSet2: ChangeSet) {
        reload(changeSet: changeSet1, reloadableView: categoryCollectionView1)
        reload(changeSet: changeSet2, reloadableView: categoryCollectionView2)
    }
    
    func reloadSubcategories(changeSet1: ChangeSet, changeSet2: ChangeSet) {
        UIView
            .animate(withDuration: 0.2) { [weak self] in
                self?.subcategoryHeader.isHidden = false
                self?.subcategoriesContainer.isHidden = false
        }
        
        reload(changeSet: changeSet1, reloadableView: subcategoryCollectionView1)
        reload(changeSet: changeSet2, reloadableView: subcategoryCollectionView2)
    }
    
    func dismiss() {
        router?.dismiss()
    }
}

extension NewEntryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView1:
            return viewModel.numberOfItemsInCategories(section: 0)
        case categoryCollectionView2:
            return viewModel.numberOfItemsInCategories(section: 1)
            
        case subcategoryCollectionView1:
            return viewModel.numberOfItemsInSubcategories(section: 0)
        case subcategoryCollectionView2:
            return viewModel.numberOfItemsInSubcategories(section: 1)
            
        default:
            assertionFailure("Not implemented")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.newEntryCollectionCell,
                                                      for: indexPath)!
        
        switch collectionView {
        case categoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            cell.text = viewModel.categoryTitle(forItemAt: indexPath)
            
        case categoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            cell.text = viewModel.categoryTitle(forItemAt: indexPath)
            
        case subcategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            cell.text = viewModel.subcategoryTitle(forItemAt: indexPath)
            
        case subcategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            cell.text = viewModel.subcategoryTitle(forItemAt: indexPath)
            
        default:
            assertionFailure("Not implemented")
        }
        
        return cell
    }
}

extension NewEntryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            viewModel.didSelectCategory(at: indexPath)
            
            if let selected = categoryCollectionView2.indexPathsForSelectedItems?.first {
                categoryCollectionView2.deselectItem(at: selected, animated: true)
            }
            
        case categoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            viewModel.didSelectCategory(at: indexPath)
            
            if let selected = categoryCollectionView1.indexPathsForSelectedItems?.first {
                categoryCollectionView1.deselectItem(at: selected, animated: true)
            }
            
        case subcategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            viewModel.didSelectSubcategory(at: indexPath)
            
            if let selected = subcategoryCollectionView2.indexPathsForSelectedItems?.first {
                subcategoryCollectionView2.deselectItem(at: selected, animated: true)
            }
            
        case subcategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            viewModel.didSelectSubcategory(at: indexPath)
            
            if let selected = subcategoryCollectionView1.indexPathsForSelectedItems?.first {
                subcategoryCollectionView1.deselectItem(at: selected, animated: true)
            }
            
        default:
            assertionFailure("Not implemented")
        }
    }
}

extension NewEntryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title: String
        
        switch collectionView {
        case categoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            title = viewModel.categoryTitle(forItemAt: indexPath)
            
        case categoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            title = viewModel.categoryTitle(forItemAt: indexPath)
            
        case subcategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            title = viewModel.subcategoryTitle(forItemAt: indexPath)
            
        case subcategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            title = viewModel.subcategoryTitle(forItemAt: indexPath)
            
        default:
            assertionFailure("Not implemented")
            title = ""
        }
        
        let atts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)]
        let stringSize = title.size(withAttributes: atts)
        let cellSize = CGSize(width: stringSize.width + Constants.cellWidthOffset, height: Constants.cellHeight)
        
        return cellSize
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case categoryCollectionView1:
            categoryCollectionView2.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(categoryCollectionView2.contentSize.width - categoryCollectionView1.contentSize.width)
            if categoryCollectionView1.contentSize.width > categoryCollectionView2.contentSize.width {
                categoryCollectionView2.contentInset.right = inset
            } else {
                categoryCollectionView1.contentInset.right = inset
            }
            
        case categoryCollectionView2:
            categoryCollectionView1.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(categoryCollectionView2.contentSize.width - categoryCollectionView1.contentSize.width)
            if categoryCollectionView1.contentSize.width > categoryCollectionView2.contentSize.width {
                categoryCollectionView2.contentInset.right = inset
            } else {
                categoryCollectionView1.contentInset.right = inset
            }
            
        case subcategoryCollectionView1:
            subcategoryCollectionView2.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(subcategoryCollectionView2.contentSize.width - subcategoryCollectionView1.contentSize.width)
            if subcategoryCollectionView1.contentSize.width > subcategoryCollectionView2.contentSize.width {
                subcategoryCollectionView2.contentInset.right = inset
            } else {
                subcategoryCollectionView1.contentInset.right = inset
            }
            
        case subcategoryCollectionView2:
            subcategoryCollectionView1.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(subcategoryCollectionView2.contentSize.width - subcategoryCollectionView1.contentSize.width)
            if subcategoryCollectionView1.contentSize.width > subcategoryCollectionView2.contentSize.width {
                subcategoryCollectionView2.contentInset.right = inset
            } else {
                subcategoryCollectionView1.contentInset.right = inset
            }
            
        default:
            assertionFailure("Not implemented")
        }
    }
}

extension NewEntryViewController: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModel.amountTextField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
}

extension NewEntryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.commentTextViewDidChange(textView.text)
    }
}

private extension NewEntryViewController {
    func setup() {
        view.backgroundColor = Colors.brandColor
        
        subcategoryHeader.isHidden = true
        subcategoriesContainer.isHidden = true
        
        walletButton.setImage(CommonUI.R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysTemplate), for: .normal)
        walletButton.addTarget(router, action: #selector(router?.presentWalletListPopover(sourceButton:)), for: .touchUpInside)
        dateButton.setImage(CommonUI.R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysTemplate), for: .normal)
        dateButton.addTarget(router, action: #selector(router?.presentDatePickerPopover(sourceButton:)), for: .touchUpInside)
        
        entryTypeSegmentedControl.addTarget(self, action: #selector(didChangeSegmentedControl), for: UIControl.Event.valueChanged)
        
        saveButton.addTarget(viewModel, action: #selector(viewModel.save), for: .touchUpInside)
        
        amountTextField.delegate = self
        commentTextView.delegate = self
        
        categoryCollectionView1.allowsSelection = true
        categoryCollectionView2.allowsSelection = true
        subcategoryCollectionView1.allowsSelection = true
        subcategoryCollectionView2.allowsSelection = true
        
        categoryCollectionView1.allowsMultipleSelection = false
        categoryCollectionView2.allowsMultipleSelection = false
        subcategoryCollectionView1.allowsMultipleSelection = false
        subcategoryCollectionView2.allowsMultipleSelection = false
        
        categoryCollectionView1.dataSource = self
        categoryCollectionView2.dataSource = self
        subcategoryCollectionView1.dataSource = self
        subcategoryCollectionView2.dataSource = self
        
        categoryCollectionView1.delegate = self
        categoryCollectionView2.delegate = self
        subcategoryCollectionView1.delegate = self
        subcategoryCollectionView2.delegate = self
        
        categoryCollectionView1.register(R.nib.newEntryCollectionCell)
        categoryCollectionView2.register(R.nib.newEntryCollectionCell)
        subcategoryCollectionView1.register(R.nib.newEntryCollectionCell)
        subcategoryCollectionView2.register(R.nib.newEntryCollectionCell)
        
        commentTextView.layer.cornerRadius = 4
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.white.cgColor
        commentTextView.clipsToBounds = true
        
        entryTypeSegmentedControl
            .setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)
                ],
                for: .normal
        )
        
        cancelButton.addTarget(router, action: #selector(router?.dismiss), for: .touchUpInside)
    }
    
    @objc
    func didChangeSegmentedControl() {
        viewModel.didSelectSegmentedControl(itemAtIndex: entryTypeSegmentedControl.selectedSegmentIndex)
    }
}
