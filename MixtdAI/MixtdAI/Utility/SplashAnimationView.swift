//
//  SplashAnimationView.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 29/07/25.
//

import UIKit

class SplashAnimationView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logoT")) // Replace with your logo name
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center

        let fullText = "BECAUSE EVERYTHING IN LIFE\nIS WORTH MIXING"

        let attributedText = NSMutableAttributedString(string: fullText)
        
        let line1Range = (fullText as NSString).range(of: "BECAUSE EVERYTHING IN LIFE")
        let line2Range = (fullText as NSString).range(of: "IS WORTH MIXING")

        // Apply styles
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .medium), range: line1Range)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 30), range: line2Range)
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: fullText.count))

        label.attributedText = attributedText
        return label
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
        backgroundColor = .black // or your desired splash background color
        addSubview(logoImageView)
        addSubview(bottomLabel)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 180),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            
            bottomLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            bottomLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            bottomLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
        
        self.showAnimationLayerView(color: .random)
    }
    
    private func startAnimation() {
        // Initial state
        logoImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        logoImageView.alpha = 0.0
        bottomLabel.alpha = 0.0
        
        // Animate logo
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.logoImageView.transform = .identity
            self.logoImageView.alpha = 1.0
        }, completion: nil)
        
        // Animate label fade-in slightly after logo
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseIn, animations: {
            self.bottomLabel.alpha = 1.0
        }, completion: { _ in
            self.fadeOutAndRemove()
        })
    }

    private func fadeOutAndRemove() {
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
