//
//  GalleryCollectionCell.swift
//
//
//  Created by Nikolas on 09.11.2023.
//

import Foundation
import UIKit
import Domain

final class GalleryCollectionCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .clear

        return prepareForAutolayout(view)
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ model: ImageModel?) {
        guard let model else {return}
        self.imageView.image = UIImage(data: model.data)
    }

    private func setupUI() {
        self.contentView.addSubviews([
            imageView
        ])

        imageView.pin(edges: [.leading, .trailing, .top, .bottom], to: contentView)
    }
}

extension GalleryCollectionCell {
    struct Inset {}
}
