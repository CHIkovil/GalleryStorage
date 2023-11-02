//
//  UIView+addSubviews.swift
//
//
//  Created by Nikolas on 23.10.2023.
//

import UIKit

public extension UIView {
    
    func addSubviews(_ views: [UIView], prepareForAutolayout needToPrepare: Bool = true) {
        views.forEach { addSubview(needToPrepare ? prepareForAutolayout($0) : $0) }
    }
}
