//
//  GalleryCollectionDataSource.swift
//
//
//  Created by Nikolas on 09.11.2023.
//

import Foundation

import UIKit
import Domain

public final class GalleryCollectionDataSource: NSObject {

    private var data: [ImageModel]?
    private unowned var collectionView: UICollectionView

    public init(
        collectionView: UICollectionView
    ) {
        self.collectionView = collectionView
    }

    func reload(_ data: [ImageModel]) {
        self.data = data
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryCollectionDataSource: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: GalleryCollectionCell.self, for: indexPath)

        cell.configure(data?[indexPath.item])

        return cell
    }
}
