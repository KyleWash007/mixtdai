//
//  LoaderAnimationView.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 29/07/25.
//

import UIKit

// MARK: - Gradient Extension
extension UIView {
    func applyGradientBackground(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.zPosition = -1
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - LoaderAnimationView
class LoaderAnimationView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mixtdlogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Something is being created for you...\nPlease wait."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var shouldAnimate = false

    // MARK: - Public API
    func startAnimation() {
        shouldAnimate = true
        animateBounce()
    }
    
    func stopAnimation() {
        shouldAnimate = false
        logoImageView.layer.removeAllAnimations()
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        backgroundColor = .black
        let animatedGradient = InstagramGradientView(frame: self.bounds)
        self.insertSubview(animatedGradient, at: 0)
        
        addSubview(logoImageView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -120),
            logoImageView.widthAnchor.constraint(equalToConstant: 180),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }

    // MARK: - Bounce Fade-In/Out Loop
    private func animateBounce() {
        guard shouldAnimate else { return }

        logoImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        logoImageView.alpha = 0.0

        UIView.animate(withDuration: 1.5,
                       delay: 0.0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
            self.logoImageView.transform = .identity
            self.logoImageView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 1.5,
                           delay: 0.3,
                           options: [.curveEaseInOut, .allowUserInteraction],
                           animations: {
                self.logoImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                self.logoImageView.alpha = 0.0
            }) { _ in
                self.animateBounce()
            }
        }
    }
}
