//
//  UITextField+publisher.swift
//  
//
//  Created by Nikolas on 08.01.2024.
//

import UIKit
import Combine

public extension UITextField {

    var textDidEndEditingPublisher: AnyPublisher<String, Never> {
        publisher(for: UITextField.textDidEndEditingNotification)
    }

    var textDidChangePublisher: AnyPublisher<String, Never> {
        publisher(for: UITextField.textDidChangeNotification)
    }

    var textDidBeginEditingPublisher: AnyPublisher<String, Never> {
        publisher(for: UITextField.textDidBeginEditingNotification)
    }

    private func publisher(
        for notification: NSNotification.Name
    ) -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: notification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
}
