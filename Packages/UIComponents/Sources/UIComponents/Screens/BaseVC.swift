//
//  BaseVC.swift
//  
//
//  Created by Sergei Gubin on 14.12.2022.
//

import UIKit

public enum ViewMode {
    case light
    case dark
}

open class BaseVC: UIViewController {

    public var currentViewMode: ViewMode = .light {
        didSet {
            updateAppearance()
        }
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupSubviews()
        setupAutolayout()
        updateAppearance()
        bind()

        registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: {(self: Self, _: UITraitCollection) in

            if self.traitCollection.userInterfaceStyle == .light {
                self.currentViewMode = .light
                self.view.backgroundColor = UIColor(hex: "#FFFFFF")

            } else {
                self.currentViewMode = .dark
                self.view.backgroundColor = UIColor(hex: "#2C2C2C")
            }
        })
    }

    // MARK: - Setup

    open func setupSubviews() {
        assertionFailure("\(#function) needs to be overriden.")
    }

    open func setupAutolayout() {
        assertionFailure("\(#function) needs to be overriden.")
    }

    open func updateAppearance() {
        fatalError("updateUI() must be overridden")
    }

    open func bind() {}
}
