//
//  UICollectionView+register.swift
//
//
//  Created by Nikolas on 09.11.2023.
//

import Foundation

import UIKit

public extension UICollectionView {

    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
}
