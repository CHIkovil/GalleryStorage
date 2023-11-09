//
//  GalleryCollectionDelegate.swift
//
//
//  Created by Nikolas on 09.11.2023.
//

import Foundation
import UIKit


public final class GalleryCollectionDelegate: NSObject {
    
    private unowned var collectionView: UICollectionView
    
    public init(
        collectionView: UICollectionView
    ) {
        self.collectionView = collectionView
    }
}

// MARK: - UICollectionViewDelegate

extension GalleryCollectionDelegate: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryCollectionDelegate: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
