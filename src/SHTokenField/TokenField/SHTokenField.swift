//
//  SHTokenField.swift
//  SHTokenField
//
//  Created by Patryk Mieszała on 03/02/2019.
//  Copyright © 2019 Patryk Mieszała. All rights reserved.
//

import UIKit

open class SHTokenField: UIView, UITextFieldDelegate {
    
    open var contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            scrollView.contentInset = contentInset
        }
    }
    
    open var suggestionsContentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            shInputAccessoryView.scrollView.contentInset = suggestionsContentInset
        }
    }
    
    open var suggestionsViewHeight: CGFloat = 44 {
        didSet {
            shInputAccessoryView.frame.size.height = suggestionsViewHeight
        }
    }
    
    public weak var dataSource: SHTokenFieldDataSource?
    public weak var delegate: SHTokenFieldDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = contentInset
        
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
        
        setup()
    }
    
    public func reload() {
        stackView
            .arrangedSubviews
            .forEach { view in
                guard view != textField else {
            return
        }
                
                stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
        
        guard let dataSource = dataSource else {
            stackView.addArrangedSubview(textField)
            
            return
        }
        
        let numberOfTokens = dataSource.numberOfTokensInTokenField(tokenField: self)
        
        for index in 0..<numberOfTokens {
            let view = dataSource.tokenField(tokenField: self, viewForTokenAtIndex: index)
            view.setContentHuggingPriority(.required, for: .horizontal)
            view.setTapGesture(target: self, action: #selector(didTapOnTokenView(gesture:)))
            
            stackView.addArrangedSubview(view)
        }
        
        textField.text = ""
        textField.keyboardType = .twitter
        textField.resignFirstResponder()
        textField.becomeFirstResponder()
        stackView.insertArrangedSubview(textField, at: numberOfTokens)
        scrollToTextFieldRect(animated: true)
    }
    
    public func reloadSuggestions() {
        let suggestionsStackView = shInputAccessoryView.stackView
        
        suggestionsStackView
            .arrangedSubviews
            .forEach { view in
                suggestionsStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
        }
        
        guard let dataSource = dataSource else {
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
    
    // MARK: - UITextFieldDelegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        scrollToTextFieldRect(animated: false)
        
        if textField.text?.count == 0, string == " " {
            return false
        }
        
        let action = SHTextFieldAction(
            currentText: textField.text ?? "",
            stringChange: string,
            range: range,
            keyboardType: textField.keyboardType
        )
        
        delegate?.tokenField(
            tokenField: self,
            decideTokenPolicyForTextFieldAction: action,
            decisionHandler: { [weak self] (policy) in
                self?.resolveToken(policy: policy)
        })
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addToken()
        
        return false
    }
}

// MARK: - private extension
private extension SHTokenField {
    
    func setup() {
        backgroundColor = .clear
        
        setupScrollView()
        setupStackView()
        setUnderline()
        setupSuggestions()
        
        textField.deleteBackwardCallback = { [weak self] in
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
                deleteIndex < self.stackView.arrangedSubviews.count {
                let view = self.stackView.arrangedSubviews[deleteIndex]
                self.stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
                
                self.delegate?.tokenField(tokenField: self, didDeleteTokenAtIndex: deleteIndex)
            }
        }
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        stackView.addArrangedSubview(textField)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnField(gesture:)))
        addGestureRecognizer(tap)
    }
    
    func setupSuggestions() {
        
        let inputAccessoryView = shInputAccessoryView
        inputAccessoryView.translatesAutoresizingMaskIntoConstraints = false
        inputAccessoryView.backgroundColor = .white
        
        let width: CGFloat = UIScreen.main.bounds.width
        inputAccessoryView.frame = CGRect(x: 0, y: 0, width: width, height: suggestionsViewHeight)
        inputAccessoryView.setup()
        
        textField.inputAccessoryView = inputAccessoryView
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    func setUnderline() {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(hex: 0x19198c)
        addSubview(line)
        
        line.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
    }
    
    func scrollToTextFieldRect(animated: Bool) {
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.01) { [weak self] in
                guard let self = self else {
                    return
                }
                self.scrollView.scrollRectToVisible(self.textField.frame, animated: animated)
        }
    }
    
    func addToken() {
        let shouldAdd: Bool = delegate?.tokenField(tokenField: self, shouldAddTokenNamed: textField.text ?? "") ?? false
        
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
            textField.keyboardType = .twitter
            textField.resignFirstResponder()
            textField.becomeFirstResponder()
            
        case .setDefaultKeyboardType:
            textField.keyboardType = .default
            textField.returnKeyType = .done
            textField.resignFirstResponder()
            textField.becomeFirstResponder()
            
        case .addToken:
            addToken()
        }
    }
    
    @objc func didTapOnField(gesture: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    @objc func textFieldDidChange() {
        delegate?.tokenField(tokenField: self, textDidChange: textField.text)
    }
    
    @objc func didTapOnTokenView(gesture: UITapGestureRecognizer) {
        guard
            let tokenView = gesture.view as? SHTokenView,
            let index = stackView.arrangedSubviews.firstIndex(of: tokenView)
            else {
            return
        }
        
        delegate?.tokenField(tokenField: self, didTapOn: tokenView, atIndex: index)
    }
    
    @objc func didTapOnSuggestionTokenView(gesture: UITapGestureRecognizer) {
        guard
            let tokenView = gesture.view as? SHTokenView,
            let index = shInputAccessoryView.stackView.arrangedSubviews.firstIndex(of: tokenView)
            else {
            return
        }
        
        delegate?.tokenField(tokenField: self, didTapOnSuggestion: tokenView, atIndex: index)
    }
}
