//
//  KeyboardTrait.swift
//
//
//  Created by Nikolas on 08.01.2024.
//

import UIKit
import Combine

public protocol KeyboardTrait: UIViewController {

    var cancellables: Set<AnyCancellable> { get set }

    func observeKeyboard(willShow: @escaping (KeyboardWillShowInfo) -> Void, willHide: @escaping () -> Void)
}

public struct KeyboardWillShowInfo {
    public let keyboardHeight: CGFloat
    public let keyboardAnimationDuration: CGFloat
}

public extension KeyboardTrait {

    func observeKeyboard(willShow: @escaping (KeyboardWillShowInfo) -> Void, willHide: @escaping () -> Void) {
        NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink(receiveValue: { notification in
                let height = (notification
                    .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                let duration = notification
                    .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0

                willShow(.init(keyboardHeight: height, keyboardAnimationDuration: duration))
            })
            .store(in: &cancellables)

        NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink(receiveValue: { _ in
                willHide()
            })
            .store(in: &cancellables)
    }
}

public enum KeyboardState {
    case hidden
    case shown(height: CGFloat)
}
