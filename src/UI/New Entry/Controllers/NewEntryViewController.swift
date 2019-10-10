//
//  NewEntryViewController.swift
//  UI
//
//  Created by Patryk Mieszała on 18/03/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

import Shared
import Domain

@objc
protocol NewEntryRouter: class {
    func presentWalletListPopover(sourceButton: UIButton)
    func presentDatePickerPopover(sourceButton: UIButton)
}

class NewEntryViewController: SheklyViewController<NewEntryViewModel> {
    
    private struct Constants {
        static let cellWidthOffset: CGFloat = 30
        static let cellHeight: CGFloat = 27
    }
    
    @IBOutlet private weak var ibCancelButton: UIButton!
    @IBOutlet private weak var ibEntryTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet private weak var ibAmountTextField: UITextField!
    
    @IBOutlet private weak var ibWalletButton: UIButton!
    @IBOutlet private weak var ibDateButton: UIButton!
    
    @IBOutlet private weak var ibCategoryCollectionView1: UICollectionView!
    @IBOutlet private weak var ibCategoryCollectionView2: UICollectionView!
    
    @IBOutlet private weak var ibSubcategoryHeader: UIView!
    @IBOutlet private weak var ibSubcategoriesContainer: UIView!
    @IBOutlet private weak var ibSubcategoryCollectionView1: UICollectionView!
    @IBOutlet private weak var ibSubcategoryCollectionView2: UICollectionView!
    
    @IBOutlet private weak var ibCommentTextView: UITextView!
    @IBOutlet private weak var ibSaveButton: UIButton!
    
    var router: NewEntryRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        ibAmountTextField.becomeFirstResponder()
    }
}

extension NewEntryViewController: ReloadableViewController {
    var reloadableView: ReloadableView? {
        return nil
    }
}

extension NewEntryViewController: NewEntryPresenter {
    func show(walletName: String?) {
        ibWalletButton.setTitle(walletName, for: .normal)
    }
    
    func show(date: String?) {
        ibDateButton.setTitle(date, for: .normal)
    }
    
    func show(amount: String, color: UIColor) {
        ibAmountTextField.text = amount
        ibAmountTextField.textColor = color
    }
    
    func setSaveButton(enabled: Bool) {
        ibSaveButton.isEnabled = enabled
    }
    
    func reloadCategories(changeSet1: ChangeSet, changeSet2: ChangeSet) {
        self.reload(changeSet: changeSet1, reloadableView: ibCategoryCollectionView1)
        self.reload(changeSet: changeSet2, reloadableView: ibCategoryCollectionView2)
    }
    
    func reloadSubcategories(changeSet1: ChangeSet, changeSet2: ChangeSet) {
        UIView
            .animate(withDuration: 0.2) {
                self.ibSubcategoryHeader.isHidden = false
                self.ibSubcategoriesContainer.isHidden = false
        }
        
        self.reload(changeSet: changeSet1, reloadableView: ibSubcategoryCollectionView1)
        self.reload(changeSet: changeSet2, reloadableView: ibSubcategoryCollectionView2)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewEntryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case ibCategoryCollectionView1:
            return viewModel.numberOfItemsInCategories(section: 0)
        case ibCategoryCollectionView2:
            return viewModel.numberOfItemsInCategories(section: 1)
            
        case ibSubcategoryCollectionView1:
            return viewModel.numberOfItemsInSubcategories(section: 0)
        case ibSubcategoryCollectionView2:
            return viewModel.numberOfItemsInSubcategories(section: 1)
            
        default:
            assertionFailure("Not implemented")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewEntryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.newEntryCollectionCell, for: indexPath)!
        
        switch collectionView {
        case ibCategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            cell.text = viewModel.categoryTitle(forItemAt: indexPath)
            
        case ibCategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            cell.text = viewModel.categoryTitle(forItemAt: indexPath)
            
        case ibSubcategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            cell.text = viewModel.subcategoryTitle(forItemAt: indexPath)
            
        case ibSubcategoryCollectionView2:
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
        case ibCategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            viewModel.didSelectCategory(at: indexPath)
            
            if let selected = ibCategoryCollectionView2.indexPathsForSelectedItems?.first {
                ibCategoryCollectionView2.deselectItem(at: selected, animated: true)
            }
            
        case ibCategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            viewModel.didSelectCategory(at: indexPath)
            
            if let selected = ibCategoryCollectionView1.indexPathsForSelectedItems?.first {
                ibCategoryCollectionView1.deselectItem(at: selected, animated: true)
            }
            
        case ibSubcategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            viewModel.didSelectSubcategory(at: indexPath)
            
            if let selected = ibSubcategoryCollectionView2.indexPathsForSelectedItems?.first {
                ibSubcategoryCollectionView2.deselectItem(at: selected, animated: true)
            }
            
        case ibSubcategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            viewModel.didSelectSubcategory(at: indexPath)
            
            if let selected = ibSubcategoryCollectionView1.indexPathsForSelectedItems?.first {
                ibSubcategoryCollectionView1.deselectItem(at: selected, animated: true)
            }
            
        default:
            assertionFailure("Not implemented")
        }
    }
}

extension NewEntryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title: String
        
        switch collectionView {
        case ibCategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            title = viewModel.categoryTitle(forItemAt: indexPath)
            
        case ibCategoryCollectionView2:
            let indexPath = IndexPath(row: indexPath.row, section: 1)
            title = viewModel.categoryTitle(forItemAt: indexPath)
            
        case ibSubcategoryCollectionView1:
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            title = viewModel.subcategoryTitle(forItemAt: indexPath)
            
        case ibSubcategoryCollectionView2:
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
        case ibCategoryCollectionView1:
            ibCategoryCollectionView2.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(ibCategoryCollectionView2.contentSize.width - ibCategoryCollectionView1.contentSize.width)
            if ibCategoryCollectionView1.contentSize.width > ibCategoryCollectionView2.contentSize.width {
                ibCategoryCollectionView2.contentInset.right = inset
            }
            else {
                ibCategoryCollectionView1.contentInset.right = inset
            }
            
        case ibCategoryCollectionView2:
            ibCategoryCollectionView1.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(ibCategoryCollectionView2.contentSize.width - ibCategoryCollectionView1.contentSize.width)
            if ibCategoryCollectionView1.contentSize.width > ibCategoryCollectionView2.contentSize.width {
                ibCategoryCollectionView2.contentInset.right = inset
            }
            else {
                ibCategoryCollectionView1.contentInset.right = inset
            }
            
        case ibSubcategoryCollectionView1:
            ibSubcategoryCollectionView2.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(ibSubcategoryCollectionView2.contentSize.width - ibSubcategoryCollectionView1.contentSize.width)
            if ibSubcategoryCollectionView1.contentSize.width > ibSubcategoryCollectionView2.contentSize.width {
                ibSubcategoryCollectionView2.contentInset.right = inset
            }
            else {
                ibSubcategoryCollectionView1.contentInset.right = inset
            }
            
        case ibSubcategoryCollectionView2:
            ibSubcategoryCollectionView1.contentOffset = scrollView.contentOffset
            
            let inset: CGFloat = abs(ibSubcategoryCollectionView2.contentSize.width - ibSubcategoryCollectionView1.contentSize.width)
            if ibSubcategoryCollectionView1.contentSize.width > ibSubcategoryCollectionView2.contentSize.width {
                ibSubcategoryCollectionView2.contentInset.right = inset
            }
            else {
                ibSubcategoryCollectionView1.contentInset.right = inset
            }
            
        default:
            assertionFailure("Not implemented")
        }
    }
}

extension NewEntryViewController: UITextFieldDelegate {
    //MARK: - UITextFieldDelegate
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
        self.view.backgroundColor = Colors.brandColor
        
        ibSubcategoryHeader.isHidden = true
        ibSubcategoriesContainer.isHidden = true
        
        ibWalletButton.setImage(R.image.tabBarWalletIcon()?.withRenderingMode(.alwaysTemplate), for: .normal)
        ibWalletButton.addTarget(router, action: #selector(router?.presentWalletListPopover(sourceButton:)), for: .touchUpInside)
        ibDateButton.setImage(R.image.tabBarPlanIcon()?.withRenderingMode(.alwaysTemplate), for: .normal)
        ibDateButton.addTarget(router, action: #selector(router?.presentDatePickerPopover(sourceButton:)), for: .touchUpInside)
        
        ibEntryTypeSegmentedControl.addTarget(self, action: #selector(didChangeSegmentedControl), for: UIControl.Event.valueChanged)
        
        ibSaveButton.addTarget(viewModel, action: #selector(viewModel.save), for: .touchUpInside)
        
        ibAmountTextField.delegate = self
        ibCommentTextView.delegate = self
        
        ibCategoryCollectionView1.allowsSelection = true
        ibCategoryCollectionView2.allowsSelection = true
        ibSubcategoryCollectionView1.allowsSelection = true
        ibSubcategoryCollectionView2.allowsSelection = true
        
        ibCategoryCollectionView1.allowsMultipleSelection = false
        ibCategoryCollectionView2.allowsMultipleSelection = false
        ibSubcategoryCollectionView1.allowsMultipleSelection = false
        ibSubcategoryCollectionView2.allowsMultipleSelection = false
        
        ibCategoryCollectionView1.dataSource = self
        ibCategoryCollectionView2.dataSource = self
        ibSubcategoryCollectionView1.dataSource = self
        ibSubcategoryCollectionView2.dataSource = self
        
        ibCategoryCollectionView1.delegate = self
        ibCategoryCollectionView2.delegate = self
        ibSubcategoryCollectionView1.delegate = self
        ibSubcategoryCollectionView2.delegate = self
        
        ibCategoryCollectionView1.register(R.nib.newEntryCollectionCell)
        ibCategoryCollectionView2.register(R.nib.newEntryCollectionCell)
        ibSubcategoryCollectionView1.register(R.nib.newEntryCollectionCell)
        ibSubcategoryCollectionView2.register(R.nib.newEntryCollectionCell)
        
        ibCommentTextView.layer.cornerRadius = 4
        ibCommentTextView.layer.borderWidth = 1
        ibCommentTextView.layer.borderColor = UIColor.white.cgColor
        ibCommentTextView.clipsToBounds = true
        
        ibEntryTypeSegmentedControl
            .setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)
                ],
                for: .normal
        )
        
        ibCancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    }
    
    @objc
    func didChangeSegmentedControl() {
        viewModel.didSelectSegmentedControl(itemAtIndex: ibEntryTypeSegmentedControl.selectedSegmentIndex)
    }
    
    @objc
    func didTapCancelButton() {
        dismiss()
    }
}
