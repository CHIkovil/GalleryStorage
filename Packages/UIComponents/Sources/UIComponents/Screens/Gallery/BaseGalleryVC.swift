//
//  BaseGalleryVC.swift
//
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation
import UIKit
import Combine
import Domain


public protocol GalleryVMProtocol {}


open class BaseGalleryVC: BaseVC {
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: Asset.trollFace.image)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Давай", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .clear
        return button
    }()
    
    
    // MARK: - Acts
    
    open func getImages(completion: @escaping ([ImageModel]) -> Void) {}
    
    // MARK: - Let
    
    let viewModel: GalleryVMProtocol
    
    // MARK: - Init

    public init(viewModel: GalleryVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getImages { [weak self] result in
            guard let self else { return }
        }
    }
    
    // MARK: - Bind
    
    open override func bind() {}

    // MARK: - Setup

    open override func setupSubviews() {
        view.backgroundColor = .white
        view.addSubviews([
            imageView
        ])
    }
    
    open override func setupAutolayout() {
        view.addConstraints([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        imageView.set(size: Size.imageSize)
    }
}

// MARK: - Private acts

private extension BaseGalleryVC {}

// MARK: - Inset

private extension BaseGalleryVC {
    
    struct Inset {}
    
    struct Size {
        static let imageSize : CGSize = .init(width: 100, height: 100)
    }
}

