//
//  Uiimage+Extention.swift
//  Leaderly
//
//  Created by Aravind Kumar on 21/06/25.
//


import UIKit

extension UIImage {
    static func imageWithFirstLetter(text: String,
                                     size: CGSize = CGSize(width: 100, height: 100),
                                     backgroundColor: UIColor = .lightGray,
                                     textColor: UIColor = .white,
                                     font: UIFont = UIFont.systemFont(ofSize: 40, weight: .bold)) -> UIImage? {
        
        // Get first letter
        guard let firstLetter = text.first else { return nil }
        let letterString = String(firstLetter).uppercased()
        
        // Begin image context
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Fill background
        context.setFillColor(backgroundColor.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        
        // Draw text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let textSize = letterString.size(withAttributes: attributes)
        let textRect = CGRect(
            x: (size.width - textSize.width) / 2,
            y: (size.height - textSize.height) / 2,
            width: textSize.width,
            height: textSize.height
        )
        
        letterString.draw(in: textRect, withAttributes: attributes)
        
        // Get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}
