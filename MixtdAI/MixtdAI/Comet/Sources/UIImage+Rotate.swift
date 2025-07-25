import UIKit

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage? {
        var newSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        draw(in: CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
// MARK: – A little UIImage “factory” for letter placeholders
extension UIImage {
    /// Generates a square image filled with `backgroundColor` and centered `letter`.
    static func letterPlaceholder(
        _ letter: String,
        size: CGSize,
        backgroundColor: UIColor = .lightGray,
        textColor: UIColor = .white,
        font: UIFont? = nil
    ) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            // Fill background
            backgroundColor.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))

            // Draw letter in center
            let attribs: [NSAttributedString.Key:Any] = [
                .font: font ?? UIFont.systemFont(ofSize: size.width / 2, weight: .bold),
                .foregroundColor: textColor
            ]
            let text = letter.uppercased()
            let textSize = text.size(withAttributes: attribs)
            let point = CGPoint(
                x: (size.width - textSize.width)/2,
                y: (size.height - textSize.height)/2
            )
            text.draw(at: point, withAttributes: attribs)
        }
    }
}
