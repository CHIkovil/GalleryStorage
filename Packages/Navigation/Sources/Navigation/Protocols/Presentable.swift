//
//  Presentable.swift
//
//  Created by Nikolas on 23.10.2023.
//

import UIKit

public protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController? {
        self
    }
}
