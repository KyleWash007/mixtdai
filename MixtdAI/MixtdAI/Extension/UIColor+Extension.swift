//
//  UIColor+Extentions.swift
//
//  Created by Kyle Wash 007 on 31/08/21.
//
import UIKit
import Foundation
import UIGradient

extension UIColor {
    /// Returns a lighter version of the color
    /// - Parameter amount: The amount to lighten (0.0 - 1.0)
    func lighter(by amount: CGFloat = 0.2) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        // Extract HSB components
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            // Increase brightness safely
            let newBrightness = min(brightness + amount, 1.0)
            return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
        }

        // Fallback for colors that can't be converted to HSB
        return self
    }
}
extension UIColor {
    
    convenience init(hexString:String?) {
        if let hexString=hexString{
            let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
            let scanner   = Scanner(string: hexString as String)
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            
            var color:UInt64 = 0
            scanner.scanHexInt64(&color)
            
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            
            self.init(red:red, green:green, blue:blue, alpha:1)
        }
        else{
            // return nil default color
            self.init(red:1, green:1, blue:1, alpha:1)
        }
    }
}
public extension UIColor {
    static func color(name: String,
                      defaultColor: UIColor = .white) -> UIColor {
        return UIColor(named: name) ?? defaultColor
    }
    
    static func gradientColors() -> [UIColor] {
        return [UIColor.color(name: "gradientComponent2"),
                UIColor.color(name: "gradientComponent1")]
    }
  
    static func darkGradientColors() -> [UIColor] {
        return [UIColor.color(name: "darkGradientComponent1"),
                UIColor.color(name: "darkGradientComponent2")]
    }
    
    static func lightGradientColors() -> [UIColor] {
        return [UIColor.color(name: "lightGradientComp1"),
                UIColor.color(name: "lightGradientComp2")]
    }
    static func fromGradient(_ gradient: GradientLayer, frame: CGRect, cornerRadius: CGFloat = 0) -> UIColor? {
        guard let image = UIImage.fromGradient(gradient, frame: frame, cornerRadius: cornerRadius) else { return nil }
        return UIColor(patternImage: image)
    }
    
    static func fromGradientWithDirection(_ direction: GradientDirection, frame: CGRect, colors: [UIColor], cornerRadius: CGFloat = 0, locations: [Double]? = nil) -> UIColor? {
        let gradient = GradientLayer(direction: direction, colors: colors, cornerRadius: cornerRadius, locations: locations)
        return UIColor.fromGradient(gradient, frame: frame)
    }
   
}
public extension UIImage {
    
    static func fromGradient(_ gradient: GradientLayer, frame: CGRect, cornerRadius: CGFloat = 0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        let cloneGradient = gradient.clone()
        cloneGradient.frame = frame
        cloneGradient.cornerRadius = cornerRadius
        cloneGradient.render(in: ctx)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func fromGradientWithDirection(_ direction: GradientDirection, frame: CGRect, colors: [UIColor], cornerRadius: CGFloat = 0, locations: [Double]? = nil) -> UIImage? {
        let gradient = GradientLayer(direction: direction, colors: colors, cornerRadius: cornerRadius, locations: locations)
        return UIImage.fromGradient(gradient, frame: frame)
    }

}

extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }

    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }

    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
