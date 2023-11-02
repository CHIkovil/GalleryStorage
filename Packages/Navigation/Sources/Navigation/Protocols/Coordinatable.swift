//
//  Coordinatable.swift
//
//  Created by Nikolas on 23.10.2023.
//

import Foundation

public protocol Coordinatable: AnyObject {
    func start()
    var finishFlow: (() -> Void)? { get set}
}
