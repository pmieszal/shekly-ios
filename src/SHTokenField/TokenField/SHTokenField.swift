//
//  SHTokenField.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class SHTokenField: UIView, UITextFieldDelegate {
    
    open var contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            self.scrollView.contentInset = contentInset
        }
    }
    
    open var suggestionsContentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            self.shInputAccessoryView.scrollView.contentInset = suggestionsContentInset
        }
    }
    
    open var suggestionsViewHeight: CGFloat = 44 {
        didSet {
            self.shInputAccessoryView.frame.size.height = suggestionsViewHeight
        }
    }
    
    public weak var dataSource: SHTokenFieldDataSource?
    public weak var delegate: SHTokenFieldDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = self.contentInset
        
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
    
    lazy var textField: SHTokenTextField = {
        let textField = SHTokenTextField()
        textField.padding.left = 0
        textField.padding.right = 0
        textField.delegate = self
        
        return textField
    }()
    
    lazy var shInputAccessoryView: SHInputAccessoryView = {
        let view = SHInputAccessoryView()
        
        return view
    }()
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    public func reload() {
        self.stackView
            .arrangedSubviews
            .forEach { view in
                guard view != self.textField else { return }
                
                self.stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
        
        guard let dataSource = self.dataSource else {
            self.stackView.addArrangedSubview(textField)
            
            return
        }
        
        let numberOfTokens = dataSource.numberOfTokensInTokenField(tokenField: self)
        
        for index in 0..<numberOfTokens {
            let view = dataSource.tokenField(tokenField: self, viewForTokenAtIndex: index)
            view.setContentHuggingPriority(.required, for: .horizontal)
            view.setTapGesture(target: self, action: #selector(didTapOnTokenView(gesture:)))
            
            self.stackView.addArrangedSubview(view)
        }
        
        self.textField.text = ""
        self.textField.keyboardType = .twitter
        self.textField.resignFirstResponder()
        self.textField.becomeFirstResponder()
        self.stackView.insertArrangedSubview(self.textField, at: numberOfTokens)
        self.scrollToTextFieldRect(animated: true)
    }
    
    public func reloadSuggestions() {
        let suggestionsStackView = self.shInputAccessoryView.stackView
        
        suggestionsStackView
            .arrangedSubviews
            .forEach { view in
                suggestionsStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
        
        guard let dataSource = self.dataSource else {
            return
        }
        
        let numberOfSuggestions = dataSource.numberOfTokenSuggestions(tokenField: self)
        
        for index in 0..<numberOfSuggestions {
            let view = dataSource.tokenField(tokenField: self, viewForTokenSuggestionAtIndex: index)
            view.setContentHuggingPriority(.required, for: .horizontal)
            view.setTapGesture(target: self, action: #selector(didTapOnSuggestionTokenView(gesture:)))
            
            suggestionsStackView.addArrangedSubview(view)
        }
    }
    
    //MARK: - UITextFieldDelegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.scrollToTextFieldRect(animated: false)
        
        if textField.text?.count == 0, string == " " {
            return false
        }
        
        let action = SHTextFieldAction(
            currentText: textField.text ?? "",
            stringChange: string,
            range: range,
            keyboardType: textField.keyboardType
        )
        
        self.delegate?.tokenField(
            tokenField: self,
            decideTokenPolicyForTextFieldAction: action,
            decisionHandler: { [weak self] (policy) in
                self?.resolveToken(policy: policy)
        })
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.addToken()
        
        return false
    }
}

//MARK: - private extension
private extension SHTokenField {
    
    func setup() {
        self.backgroundColor = .clear
        
        self.setupScrollView()
        self.setupStackView()
        self.setUnderline()
        self.setupSuggestions()
        
        self.textField.deleteBackwardCallback = { [weak self] in
            guard let self = self,
                self.textField.text?.isEmpty == true,
                let index: Int = self.dataSource?.numberOfTokensInTokenField(tokenField: self),
                index > 0
                else {
                    
                    return
            }
            
            let deleteIndex = index - 1
            
            let shouldDelete: Bool = self.delegate?.tokenField(tokenField: self, shouldDeleteTokenAtIndex: deleteIndex) ?? false
            
            if shouldDelete == true,
                deleteIndex < self.stackView.arrangedSubviews.count
            {
                let view = self.stackView.arrangedSubviews[deleteIndex]
                self.stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
                
                self.delegate?.tokenField(tokenField: self, didDeleteTokenAtIndex: deleteIndex)
            }
        }
        
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        self.stackView.addArrangedSubview(self.textField)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnField(gesture:)))
        self.addGestureRecognizer(tap)
    }
    
    func setupSuggestions() {
        
        let inputAccessoryView = self.shInputAccessoryView
        inputAccessoryView.translatesAutoresizingMaskIntoConstraints = false
        inputAccessoryView.backgroundColor = .white
        
        let width: CGFloat = UIScreen.main.bounds.width
        inputAccessoryView.frame = CGRect(x: 0, y: 0, width: width, height: self.suggestionsViewHeight)
        inputAccessoryView.setup()
        
        self.textField.inputAccessoryView = inputAccessoryView
    }
    
    func setupScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.scrollView)
        
        self.scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupStackView() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.stackView)
        
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
    }
    
    func setUnderline() {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(hex: 0x19198c)
        self.addSubview(line)
        
        line.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        line.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
    }
    
    func scrollToTextFieldRect(animated: Bool) {
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.01) { [weak self] in
                guard let self = self else { return }
                
                self.scrollView.scrollRectToVisible(self.textField.frame, animated: animated)
        }
    }
    
    func addToken() {
        let shouldAdd: Bool = self.delegate?.tokenField(tokenField: self, shouldAddTokenNamed: self.textField.text ?? "") ?? false
        
        if shouldAdd == true {
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 0.01) { [weak self] in
                    self?.reload()
            }
        }
    }
    
    func resolveToken(policy: SHTextFieldActionPolicy) {
        switch policy {
        case .setTwitterKeyboardType:
            self.textField.keyboardType = .twitter
            self.textField.resignFirstResponder()
            self.textField.becomeFirstResponder()
            
        case .setDefaultKeyboardType:
            self.textField.keyboardType = .default
            self.textField.returnKeyType = .done
            self.textField.resignFirstResponder()
            self.textField.becomeFirstResponder()
            
        case .addToken:
            self.addToken()
        }
    }
    
    @objc func didTapOnField(gesture: UITapGestureRecognizer) {
        self.textField.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange() {
        self.delegate?.tokenField(tokenField: self, textDidChange: self.textField.text)
    }
    
    @objc func didTapOnTokenView(gesture: UITapGestureRecognizer) {
        guard
            let tokenView = gesture.view as? SHTokenView,
            let index = self.stackView.arrangedSubviews.firstIndex(of: tokenView)
            else { return }
        
        self.delegate?.tokenField(tokenField: self, didTapOn: tokenView, atIndex: index)
    }
    
    @objc func didTapOnSuggestionTokenView(gesture: UITapGestureRecognizer) {
        guard
            let tokenView = gesture.view as? SHTokenView,
            let index = self.shInputAccessoryView.stackView.arrangedSubviews.firstIndex(of: tokenView)
            else { return }
        
        self.delegate?.tokenField(tokenField: self, didTapOnSuggestion: tokenView, atIndex: index)
    }
}
