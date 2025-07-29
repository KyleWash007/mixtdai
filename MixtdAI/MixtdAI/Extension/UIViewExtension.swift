//
//  UIViewExtension.swift
//  lettersApp
//
//  Created by mac on 16/03/22.
//

import Foundation
import UIKit
import CoreImage


extension UIView {
    
    func addActivityIndigator() {
        let indigator = UIActivityIndicatorView(frame: self.bounds)
        indigator.style = .medium
        indigator.color = .white
        indigator.startAnimating()
        indigator.tag = 10000
        self.addSubview(indigator)
        
    }
    
    func removeActivityIndigator() {
        if let indigator = self.subviews.first(where: {$0.tag == 10000}) as? UIActivityIndicatorView {
            indigator.stopAnimating()
            indigator.removeFromSuperview()
        }
    }
    
}



extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
//        let size = self.size

//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
//        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: targetSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}


extension CIImage {
    static let resizeFilter = CIFilter(name:"CILanczosScaleTransform")!
    
    func resizeCIImage(targetSize: CGSize) -> CIImage? {
        let resizeFilter = CIImage.resizeFilter
        // Desired output size
        
        // Compute scale and corrective aspect ratio
        let scale = targetSize.height / (self.extent.height)
        let aspectRatio = targetSize.width/((self.extent.width) * scale)

        // Apply resizing
        resizeFilter.setValue(self, forKey: kCIInputImageKey)
        resizeFilter.setValue(scale, forKey: kCIInputScaleKey)
        resizeFilter.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)
        return resizeFilter.outputImage
    }
    
}
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            if  (newValue?.isKind(of: UIColor.self))!{
                self.layer.borderColor = newValue?.cgColor
            }
        }
    }
    
    @IBInspectable var rightBorder: CGFloat {
        get {
            return 0.0
        }
        set {
            let line = UIView(frame: CGRect(x: self.bounds.width, y: 0.0, width: newValue, height: self.bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = self.borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var BorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var topBorder: CGFloat {
        get {
            return 0.0
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            if let color = self.borderColor{
            line.backgroundColor = color
            } else {
                line.backgroundColor = UIColor(named: "CellSeprator1")
            }
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
        }
    }
    @IBInspectable var leftBorder: CGFloat {
        get {
            return 0.0
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: self.bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = self.borderColor
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
        }
    }
    @IBInspectable var bottomBorder: CGFloat {
        get {
            return 0.0
        }
        set {
            let line = UIView(frame: CGRect(x: 0.0, y: self.bounds.height, width: self.bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            if let color = self.borderColor {
            line.backgroundColor = color
            } else {
                line.backgroundColor = UIColor(named: "CellSeprator1")
            }
            self.addSubview(line)
            
            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
        }
    }
  
    @IBInspectable var masksToBounds: Bool  {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
        
    }
    
 
    //shadowRadius
}
extension UIButton {
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.frame.size.height)
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.zPosition = -1
        
        // Remove old gradient layers
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
