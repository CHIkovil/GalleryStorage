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


open class BaseGalleryVC: BaseVC {
    
    // MARK: - Subviews
    
    private lazy var galleryCollectionView: UICollectionView = {
        let layout = SelectionCollectionViewLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator = false
        v.isPagingEnabled = false
        v.bounces = true
        v.contentInsetAdjustmentBehavior = .never
        
        return prepareForAutolayout(v)
    }()

    
    // MARK: - Open acts
    
    open func getImages(completion: @escaping ([ImageModel]) -> Void) {}
    
    
    // MARK: - Init
    
    private var galleryCollectionDataSource: GalleryCollectionDataSource!
    private var galleryCollectionDelegate: GalleryCollectionDelegate!
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.galleryCollectionDataSource = .init(collectionView: self.galleryCollectionView)
        self.galleryCollectionDelegate = .init(collectionView: self.galleryCollectionView)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.register(GalleryCollectionCell.self)
        galleryCollectionView.dataSource = galleryCollectionDataSource
        galleryCollectionView.delegate = galleryCollectionDelegate
        bind()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Soon:
//        self.getImages { [weak self] result in
//            guard let self else { return }
//        }
        
        let imageModels = [Asset.picture1.image.pngData(),
                           Asset.picture2.image.pngData(),
                           Asset.picture3.image.pngData()].map {ImageModel(uid: UUID().uuidString.lowercased(), data: $0 ?? Data())}
        
        galleryCollectionDataSource.reload(imageModels)
    }
    
    // MARK: - Bind
    
    open override func bind() {}

    // MARK: - Setup

    open override func setupSubviews() {
        view.backgroundColor = .black
        view.addSubviews([
            galleryCollectionView
        ])
    }
    
    open override func setupAutolayout() {
        galleryCollectionView.pin(to: view)
    }
}

// MARK: - Private acts

private extension BaseGalleryVC {}

// MARK: - Inset

private extension BaseGalleryVC {
    
    struct Inset {}
    
    struct Size {}
}

