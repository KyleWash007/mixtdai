//
//  SplashAnimationView.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 29/07/25.
//


import UIKit

class SplashAnimationView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mixtdlogo")) // Replace with your logo name
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        startAnimation()
    }
    
    private func setupView() {
        backgroundColor = .white // or your desired splash background color
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 180),
            logoImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func startAnimation() {
        // Initial state
        logoImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        logoImageView.alpha = 0.0
        
        // Scale & fade-in
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.transform = .identity
            self.logoImageView.alpha = 1.0
        }) { _ in
            // Fade out entire view after delay
            self.fadeOutAndRemove()
        }
    }
    
 
    private func fadeOutAndRemove() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
