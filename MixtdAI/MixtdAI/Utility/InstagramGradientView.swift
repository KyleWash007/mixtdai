//
//  InstagramGradientView.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 29/07/25.
//


import UIKit

class InstagramGradientView: UIView {

    private let gradientLayer = CAGradientLayer()
    
    private let colorSets: [[CGColor]] = [
        [UIColor.systemPink.cgColor, UIColor.orange.cgColor],
        [UIColor.purple.cgColor, UIColor.systemPink.cgColor],
        [UIColor.cyan.cgColor, UIColor.blue.cgColor],
        [UIColor.red.cgColor, UIColor.purple.cgColor]
    ].shuffled()
    
    private var currentIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        startAnimatingGradient()
        self.showAnimationLayerView(color: .white.withAlphaComponent(0.8))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        startAnimatingGradient()
    }

    private func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = colorSets[currentIndex]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.type = .axial
        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func startAnimatingGradient() {
        animateGradient()
    }

    private func animateGradient() {
        let nextIndex = (currentIndex + 1) % colorSets.count
        let nextColors = colorSets[nextIndex]

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = nextColors
        animation.duration = 5.0
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.gradientLayer.colors = nextColors
            self.currentIndex = nextIndex
            self.animateGradient() // loop again
        }

        gradientLayer.add(animation, forKey: "smoothColorChange")
        CATransaction.commit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
