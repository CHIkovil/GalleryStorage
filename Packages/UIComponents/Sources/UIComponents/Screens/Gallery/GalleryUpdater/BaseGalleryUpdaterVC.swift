//
//  BaseGalleryUpdaterVC.swift
//
//
//  Created by Nikolas on 30.12.2023.
//

import Foundation
import UIKit
import Combine

open class BaseGalleryUpdaterVC: BaseVC {
    
    // MARK: - Subviews
    
    private lazy var draggerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#B6B6B6")
        v.alpha = 0.5
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 2
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = FontFamily.SFUIDisplay.semibold.font(size: 20)
        v.text = "Введите веб-адрес"
        v.backgroundColor = .clear
        v.textAlignment = .left
        return v
    }()
    
    private lazy var textField: UITextField = {
        let v = UITextField()
        v.font = FontFamily.SFUIDisplay.regular.font(size: 16)
        v.keyboardType = .default
        v.backgroundColor = .clear
        v.layer.borderWidth = 1
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 12
        v.textAlignment = .center
        v.becomeFirstResponder()
        v.setLeftPaddingPoints(5)
        v.setRightPaddingPoints(5)
        v.delegate = self
        return v
    }()
    
    private lazy var errorLabel: UILabel = {
        let v = UILabel()
        v.font = FontFamily.SFUIDisplay.regular.font(size: 14)
        v.textColor = UIColor(hex: "#CD573D")
        v.isHidden = true
        v.numberOfLines = 0
        v.textAlignment = .left
        return v
    }()
    
    private lazy var checkingButton: UICheckingButton = {
        let v = UICheckingButton(frame: .zero, arcLoaderColor: UIColor(hex: "#E4E4E4"), backgroundLoaderColor: UIColor(hex: "#444444"))
        v.title = "Добавить"
        return v
    }()
    
    private lazy var contentContainerView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = true
        return v
    }()
    
    // MARK: - Open acts
    
    open func updateGallery(url: String, completion: @escaping (String?) -> Void) {}
    
    // MARK: - Init
    
    private var containerBottomConstraint: NSLayoutConstraint!
    private var defaultContentHeight: Double!
    public var cancellables = Set<AnyCancellable>()
    private var isSetError: Bool = false
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    open override func bind() {
        checkingButton
            .publisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                guard let url = self.textField.text, self.verifyUrl(url) else {
                    self.updateError("Невалидный веб-адрес")
                    return
                }
                
                self.textField.endEditing(true)
                self.updateError(nil)
                self.checkingButton.isCheck = true
                self.updateContentSize(height: defaultContentHeight * 0.4)
                
                self.updateGallery(url: url) {[weak self] error in
                    guard let self else { return }
                    self.checkingButton.isCheck = false
                    
                    if error == nil {
                        self.dismiss(animated: true)
                    }else {
                        self.textField.becomeFirstResponder()
                        self.updateError(error)
                    }
                }
            }
            .store(in: &cancellables)
        
        textField.textDidChangePublisher.receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                guard let self else {return}
                self.textField.text = self.textField.text?.trimmingCharacters(in: .whitespaces)
                
                if isSetError {
                    updateError(nil)
                }
            }).store(in: &cancellables)
        
        observeKeyboard(
            willShow: { [weak self] info in
                guard let self else { return }
                self.updateBottomConstraint(for: .shown(height: info.keyboardHeight))
                UIView.animate(withDuration: info.keyboardAnimationDuration) {
                    self.view.layoutIfNeeded()
                }
            },
            willHide: { [weak self] in
                guard let self else { return }
                self.updateBottomConstraint(for: .hidden)
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        )
    }
    
    
    open override func setupSubviews() {
        view.addSubviews([
            draggerView,
            contentContainerView
        ])
        
        contentContainerView.addSubviews([
            titleLabel,
            textField,
            errorLabel,
            checkingButton
        ])
    }
    
    open override func setupAutolayout() {
        draggerView.set(size: Size.draggerViewSize)
        
        contentContainerView.pin(
            edges: [.leading, .trailing],
            to: view,
            inset: Inset.contentIndent,
            toSafeArea: true
        )
        
        titleLabel.pin(edges: [.leading, .trailing], to: contentContainerView)
        titleLabel.set(height: 24)
        
        textField.pin(edges: [.leading, .trailing], to: contentContainerView)
        textField.set(height: 52)
        
        errorLabel.pin(edges: [.leading, .trailing], to: contentContainerView)
        errorLabel.set(height: 35)
        
        checkingButton.pin(edges: [.leading, .trailing], to: contentContainerView)
        checkingButton.set(height: 52)
        checkingButton.pin(edges: [.bottom], to: contentContainerView)
        
        view.addConstraints([
            draggerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            draggerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            contentContainerView.topAnchor.constraint(equalTo: draggerView.bottomAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
        ])
        
        updateBottomConstraint(for: .hidden)
        defaultContentHeight = self.preferredContentSize.height
    }
    
    private func updateBottomConstraint(for keyboardState: KeyboardState) {
        containerBottomConstraint?.isActive = false
        
        switch keyboardState {
        case .hidden:
            containerBottomConstraint = contentContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Inset.contentIndent)
        case .shown(let height):
            containerBottomConstraint = contentContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -height - 20)
        }
        
        containerBottomConstraint.isActive = true
    }
    
    // MARK: - Appearance
    
    open override func updateAppearance() {
        switch currentViewMode {
        case .light:
            titleLabel.textColor = UIColor(hex: "#181818")
            textField.textColor = UIColor(hex: "#181818")
            
            if textField.isEditing {
                textField.layer.borderColor = UIColor(hex: "#3A3A3A").cgColor
            } else {
                textField.layer.borderColor = UIColor(hex: "#B6B6B6").cgColor
            }
            
            textField.tintColor = UIColor(hex: "#181818")
            
            checkingButton.backgroundColor = UIColor(hex: "#181818")
            checkingButton.titleTextColor = UIColor(hex: "#FFFFFF")
            checkingButton.changeLoaderAppearance(arcColor: UIColor(hex: "#E4E4E4"), backgroundColor: UIColor(hex: "#444444"))
        case .dark:
            titleLabel.textColor = UIColor(hex: "#F5F5F5")
            textField.textColor = UIColor(hex: "#F5F5F5")
            
            if textField.isEditing {
                textField.layer.borderColor = UIColor(hex: "#E4E4E4").cgColor
            } else {
                textField.layer.borderColor = UIColor(hex: "#4A4A4A").cgColor
            }
            
            textField.tintColor = UIColor(hex: "#E4E4E4")
            
            checkingButton.backgroundColor = UIColor(hex: "#E4E4E4")
            checkingButton.titleTextColor = UIColor(hex: "#181818")
            checkingButton.changeLoaderAppearance(arcColor: UIColor(hex: "#181818"), backgroundColor: UIColor(hex: "#B6B6B6"))
        }
    }
}

// MARK: - Private acts

private extension BaseGalleryUpdaterVC {
    func updateError(_ error: String?) {
        if let error = error {
            errorLabel.isHidden = false
            errorLabel.text = error
            isSetError = true
            
            textField.layer.borderColor = UIColor(hex: "#CD573D").cgColor
            
            updateContentSize(height: defaultContentHeight + Size.errorHeight)
        } else {
            errorLabel.isHidden = true
            isSetError = false
            
            if traitCollection.userInterfaceStyle == .light {
                textField.layer.borderColor = UIColor(hex: "#3A3A3A").cgColor
            } else {
                textField.layer.borderColor = UIColor(hex: "#E4E4E4").cgColor
            }
            
            updateContentSize(height: defaultContentHeight)
        }
    }
    
    func updateContentSize(height: Double) {
        preferredContentSize = CGSize(width: preferredContentSize.width, height: height)
        view.layoutIfNeeded()
    }
    
    func verifyUrl(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}

// MARK: - UITextFieldDelegate

extension BaseGalleryUpdaterVC: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if traitCollection.userInterfaceStyle == .light {
            textField.layer.borderColor = UIColor(hex: "#3A3A3A").cgColor
        } else {
            textField.layer.borderColor = UIColor(hex: "#E4E4E4").cgColor
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if traitCollection.userInterfaceStyle == .light {
            textField.layer.borderColor = UIColor(hex: "#B6B6B6").cgColor
        } else {
            textField.layer.borderColor = UIColor(hex: "#4A4A4A").cgColor
        }
    }
}

// MARK: - KeyboardTrait

extension BaseGalleryUpdaterVC: KeyboardTrait {}

// MARK: - Inset

private extension BaseGalleryUpdaterVC {
    
    struct Inset {
        static let contentIndent: CGFloat = 20
        static let contentHeightPass: CGFloat = 40
    }
    
    struct Size {
        static let errorHeight: CGFloat = 40
        static let draggerViewSize: CGSize = .init(width: 32, height: 4)
    }
}
