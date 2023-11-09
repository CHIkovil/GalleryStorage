//
//  UICollectionView+dequeue.swift
//
//
//  Created by Nikolas on 09.11.2023.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func dequeue<T: AnyObject>(
        cell cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        dequeueReusableCell(
            withReuseIdentifier: String(describing: cellType),
            for: indexPath
        ) as! T
    }
}
