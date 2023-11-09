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
        let v = UIImageView()
        v.contentMode = .scaleToFill
        v.backgroundColor = .clear
        
        return prepareForAutolayout(v)
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
            imageView,
        ])
        
        imageView.pin(edges: [.leading, .trailing, .top, .bottom], to: contentView)
    }
}

extension GalleryCollectionCell {
    struct Inset {}
}
