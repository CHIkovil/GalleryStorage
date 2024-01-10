//
//  UICheckingButton.swift
//
//
//  Created by Nikolas on 08.01.2024.
//

import UIKit

public final class UICheckingButton: UIControl {

    // MARK: - State

    public enum State {
        case active
        case check
    }

    private var buttonState: State = .active

    // MARK: - Override

    public var isCheck: Bool {
        didSet {
            buttonState = isCheck ? .check : .active
            updateAppearance()
        }
    }

    public var title = "" {
        didSet {
            titleLabel.text = title
        }
    }

    public var titleTextColor: UIColor = UIColor(hex: "#181818") {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }

    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = FontFamily.SFUIDisplay.bold.font(size: 16)
        v.isHidden = false
        v.text = title
        v.textColor = titleTextColor
        return prepareForAutolayout(v)
    }()

    private lazy var circleLoader: UICircleLoader = {
        let v = UICircleLoader()
        v.isHidden = true
        return prepareForAutolayout(v)
    }()

    // MARK: - Init

    public init(frame: CGRect, arcLoaderColor: UIColor = UIColor(hex: "#181818"), backgroundLoaderColor: UIColor = UIColor(hex: "#E4E4E4")) {
        self.isCheck = false

        super.init(frame: frame)

        clipsToBounds = true
        setupUI()

        circleLoader.setupLoader(arcColor: arcLoaderColor, backgroundColor: backgroundLoaderColor)
    }

    // MARK: - Acts

    func changeLoaderAppearance(arcColor: UIColor, backgroundColor: UIColor) {
        circleLoader.updateAppearance(arcColor: arcColor, backgroundColor: backgroundColor)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }

    // MARK: - Setup

    private func setupUI() {
        addSubviews([
            titleLabel,
            circleLoader
        ])

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            circleLoader.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleLoader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        circleLoader.set(width: 24, height: 24)
    }
}

// MARK: - Appearance

private extension UICheckingButton {

    func updateAppearance() {
        switch buttonState {
        case .active:
            isUserInteractionEnabled = true
            titleLabel.isHidden = false

            circleLoader.isHidden = true
            circleLoader.stopAnimating()
        case .check:
            isUserInteractionEnabled = false
            titleLabel.isHidden = true

            circleLoader.isHidden = false
            circleLoader.startAnimating()
        }
    }
}
