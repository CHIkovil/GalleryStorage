//
//  File.swift
//  
//
//  Created by Nikolas on 23.10.2023.
//

import UIKit

public func prepareForAutolayout<T: UIView>(_ view: T) -> T {
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
}
