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

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = false
        view.bounces = true
        view.contentInsetAdjustmentBehavior = .never

        return prepareForAutolayout(view)
    }()

    private lazy var updaterButton: UIButton = {
        let view = UIButton()
        let icon = Asset.plus.image.withRenderingMode(.alwaysTemplate)
        view.setImage(icon, for: .normal)
        view.tintColor = .white
        view.alpha = 0.5
        return view
    }()

    // MARK: - Open acts

    open func getImages(completion: @escaping ([ImageModel]) -> Void) {}
    open func moveToUpdater() {}

    // MARK: - Init

    private var cancellables = Set<AnyCancellable>()

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
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Soon:
//        self.getImages { [weak self] result in
//            guard let self else { return }
//        }

        let imageModels = [Asset.picture1.image.pngData(),
                           Asset.picture2.image.pngData(),
                           Asset.picture3.image.pngData()].map {ImageModel(uid: UUID().uuidString.lowercased(), data: $0 ?? Data())}

        galleryCollectionDataSource.reload(imageModels)
    }

    // MARK: - Bind

    open override func bind() {
        updaterButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self else { return }
                self.moveToUpdater()
            }
            .store(in: &cancellables)
    }

    // MARK: - Setup

    open override func setupSubviews() {
        view.backgroundColor = .black
        view.addSubviews([
            galleryCollectionView,
            updaterButton
        ])
    }

    open override func setupAutolayout() {
        galleryCollectionView.pin(to: view)

        updaterButton.pin(edges: [.top, .trailing], to: view, inset: Inset.updaterButtonIndent, toSafeArea: true)
        updaterButton.set(size: Size.updaterButtonSize)
    }

    open override func updateAppearance() {}
}

// MARK: - Private acts

private extension BaseGalleryVC {}

// MARK: - Inset

private extension BaseGalleryVC {

    struct Inset {
        static let updaterButtonIndent: CGFloat = 20
    }

    struct Size {
        static let updaterButtonSize: CGSize = .init(width: 45, height: 45)
    }
}
