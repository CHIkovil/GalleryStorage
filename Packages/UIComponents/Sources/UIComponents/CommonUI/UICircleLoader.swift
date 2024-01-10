//
//  UICircleLoader.swift
//  
//
//  Created by Nikolas on 08.01.2024.
//

import Foundation
import UIKit

public final class UICircleLoader: UIView {
    private var circleLayer: CAShapeLayer?

    public func setupLoader(arcColor: UIColor, backgroundColor: UIColor) {
        let radius = 9.0
        let center = CGPoint(x: 12, y: 12)

        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = UIBezierPath(arcCenter: center,
                                                 radius: radius,
                                                 startAngle: 0,
                                                 endAngle: .pi * 2,
                                                 clockwise: true).cgPath
        backgroundLayer.strokeColor = backgroundColor.cgColor
        backgroundLayer.lineWidth = 2
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.name = "background"

        let arcLayer = CAShapeLayer()
        arcLayer.path = UIBezierPath(arcCenter: center,
                                           radius: radius,
                                           startAngle: 0,
                                           endAngle: .pi / 2,
                                           clockwise: true).cgPath
        arcLayer.strokeColor = arcColor.cgColor
        arcLayer.lineWidth = 2
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.position = center
        arcLayer.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
        arcLayer.name = "arc"

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(arcLayer)

        self.circleLayer = arcLayer
    }

    public func updateAppearance(arcColor: UIColor, backgroundColor: UIColor) {
        layer.sublayers?.forEach {
            guard let layer = $0 as? CAShapeLayer else {return}
            if layer.name == "arc"{
                layer.strokeColor = arcColor.cgColor
            }
            if layer.name == "background"{
                layer.strokeColor = backgroundColor.cgColor
            }

        }
    }

    public func startAnimating() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 1.5
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.repeatCount = .infinity
        circleLayer?.add(animation, forKey: "rotationAnimation")
    }

    public func stopAnimating() {
        circleLayer?.removeAllAnimations()
    }
}
