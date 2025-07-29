//
//  Extensions.swift
//  Recreation Rentalz
//
//   Created on 6/25/18.
//  Copyright © 2018 Iron Forge Development, LLC. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import AVFoundation

extension UIColor {
    
    enum NAME: String {
        case color_dark_blue
        case color_gray_background
        case color_gray_light
        case color_yellow
        case darkBg
    }
    
    convenience init?(colorName: NAME) {
        self.init(named: colorName.rawValue)
    }
    
    
    @nonobjc class var diversityPopBlue: UIColor {
        //return UIColor(red: 117/255, green: 136/255, blue: 255/255, alpha: 1.0)
        return UIColor(red: 22/255, green: 28/255, blue: 166/255, alpha: 1.0)
    }
    
    @nonobjc class var cornflower: UIColor {
        return UIColor(red: 103.0 / 255.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var borderGrey: UIColor {
        return UIColor(white: 227.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var unselectedTextGrey: UIColor {
        return UIColor(white: 170.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var orangeish: UIColor {
        return UIColor(red: 247.0 / 255.0, green: 141.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmPink: UIColor {
        return UIColor(red: 247.0 / 255.0, green: 78.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var dodgerBlue: UIColor {
        //return UIColor(red: 78.0 / 255.0, green: 136.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
        return UIColor(red: 22/255, green: 28/255, blue: 166/255, alpha: 1.0)
    }
    
    func brightened(by factor: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * factor, alpha: a)
    }
    
    @nonobjc class var seaGreen: UIColor {
        return UIColor(red: 67.0 / 255.0, green: 1.0, blue: 199.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var orangeishTwo: UIColor {
        return UIColor(red: 1.0, green: 154.0 / 255.0, blue: 69.0 / 255.0, alpha: 1.0)
    }

}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

public extension Sequence where Element: Equatable {
    var uniqueElements: [Element] {
        return self.reduce(into: []) {
            uniqueElements, element in
            
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
    }
}

extension UIColor {
    
    @nonobjc class var fadedOrange: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 162.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var coral: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 91.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueberry: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 63.0 / 255.0, blue: 142.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var fadedRed: UIColor {
        return UIColor(red: 217.0 / 255.0, green: 57.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var offWhite: UIColor {
        return UIColor(red: 247.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmGrey: UIColor {
        return UIColor(white: 148.0 / 255.0, alpha: 1.0)
    }
    
    
    @nonobjc class var sunflowerYellow: UIColor {
        return UIColor(red: 1.0, green: 223.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var greyish: UIColor {
        return UIColor(white: 172.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var textFieldBorderLightGrey: UIColor {
        return UIColor(white: 241.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var dullOrange: UIColor {
        return UIColor(red: 217.0 / 255.0, green: 174.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pastelRed: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 84.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tiffanyBlue: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 213.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var dullYellow: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 203.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
}


// MARK: UIView
extension UIView {
    func removeDashedLine() {
        _ = layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
    }
    
    func addDashedBorder(color: UIColor = UIColor.white.withAlphaComponent(0.50)) {
        let color = color.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [10,10]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}




extension String {
    
    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                return ($0 + " " + String($1))
            }
            else {
                return $0 + String($1)
            }
        }
    }
}

extension UILabel {
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.visibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    var visibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}

extension UITextField {
    
    @IBInspectable
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        } set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    
    func whitePlaceholder(placeholderText: String, withAlpha: CGFloat = 0.50) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(withAlpha)
            ])
    }
    
    func standardize(text: String) {
        self.whitePlaceholder(placeholderText: text)
        self.bottomBorder(with: .white, width: 1.0)
        self.tintColor = .white
        self.textColor = .white
    }
}

public extension UIView {
    func fadeIn(duration: TimeInterval = 0.7) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
    func fadeOut(duration: TimeInterval = 0.7) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
        }
    }
}

extension UITextView {
    func setLineSpacing(lineHeightMultiple: CGFloat = 1.20, text: String) {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.27
        let attributes = [
            NSAttributedString.Key.paragraphStyle : style,
            NSAttributedString.Key.font: UIFont(name: "Karla-Regular", size: 13)!,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        self.attributedText = NSAttributedString(string: text, attributes:attributes)
    }
}


extension UIView {
    
    fileprivate var bezierPathIdentifier:String { return "bezierPathBorderLayer" }
    
    fileprivate var bezierPathBorder:CAShapeLayer? {
        return (self.layer.sublayers?.filter({ (layer) -> Bool in
            return layer.name == self.bezierPathIdentifier && (layer as? CAShapeLayer) != nil
        }) as? [CAShapeLayer])?.first
    }
    
    func borderOnOutside(_ color:UIColor = .white, width:CGFloat = 1) {
        
        var border = self.bezierPathBorder
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius:self.layer.cornerRadius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        if (border == nil) {
            border = CAShapeLayer()
            border!.name = self.bezierPathIdentifier
            self.layer.addSublayer(border!)
        }
        
        border!.frame = self.bounds
        let pathUsingCorrectInsetIfAny =
            UIBezierPath(roundedRect: border!.bounds, cornerRadius:self.layer.cornerRadius)
        
        border!.path = pathUsingCorrectInsetIfAny.cgPath
        border!.fillColor = UIColor.clear.cgColor
        border!.strokeColor = color.cgColor
        border!.lineWidth = width * 2
    }
    
    func removeBezierPathBorder() {
        self.layer.mask = nil
        self.bezierPathBorder?.removeFromSuperlayer()
    }
    
}

extension UIView {
    
    func border(color: UIColor, borderWidth: CGFloat = 1.0, cornerRadius: CGFloat = 0.00) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
    
    func bottomBorder(with color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func rounded() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
    func fadeToBottom(alpha: CGFloat = 1.0) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: alpha).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.4)
        self.layer.mask = gradientLayer;
    }
    
    func fadeToTop(alpha: CGFloat = 1.0) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: alpha).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.layer.mask = gradientLayer;
    }
}
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension Date {
    func allDates(till endDate: Date) -> [Date] {
        var date = self
        var array: [Date] = []
        while date <= endDate {
            array.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return array
    }
}


extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float,
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat,
        spread: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func standardShadow() {
        self.applySketchShadow(color: UIColor(red: 103/255.0, green: 125/255.0, blue: 192/255.0, alpha: 1.0), alpha: 0.3, x: 8, y: 8, blur: 30, spread: 0)
    }
    
    func whiteShadow() {
        self.applySketchShadow(color: .white, alpha: 0.8, x: 8, y: 8, blur: 30, spread: 0)
    }
}

extension UICollectionView {
    func register(nibName: String, reuseIdentifier: String) {
        self.register(UINib.init(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    func useQuizOptionsLayout(withItemSize size: CGSize, andSpacing spacing: CGFloat){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = size
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func useHorizontalLayout(withItemSize size: CGSize, andSpacing spacing: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = size
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.setCollectionViewLayout(layout, animated: true)
    }
}

extension UIImageView {
    func set(url: String, placeholder:UIImage? = nil) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: [.transition(ImageTransition.fade(0.5))]) { (result) in}
    }
    
    func setWithPlaceholder(imageString: String, withFade: Bool = false, withExactImage: UIImage = HUDManager.getRandomPlaceholderImage()) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.kf.setImage(with: URL(string: imageString), placeholder: withExactImage, options: [.transition(ImageTransition.fade(0.5))]) { (result) in}
    }
    func getRandomPlaceholderImage() -> UIImage {
        if let random = UIImage(named: "\(arc4random_uniform(100))") {
            return random
        } else {
            return #imageLiteral(resourceName: "72")
        }
    }
    func setWithFallback(with: String) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.kf.setImage(with: URL(string: with), placeholder: nil, options: [.transition(ImageTransition.fade(0.5))]) { (result) in
            switch result{
            case .success(let imgResult): break
            case .failure(let error):
                self.image = HUDManager.getRandomPlaceholderImage()
            }
        }
    }
    
}

extension String {
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        return attributedString.string
    }
    
    
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    
    
    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension UITableView {
    func scrollToBottom(_ animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: IndexPath(row: row - 1, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }
    
    func register(nibName: String, reuseIdentifier: String) {
        self.register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
}

extension UIImage {
    
    func with(color: UIColor) -> UIImage {
        guard let cgImage = self.cgImage else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: imageRect, mask: cgImage)
        color.setFill()
        context.fill(imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }
    
    
}

extension UINavigationController {
    func transparent() {
        self.setNavigationBarHidden(false, animated: true)
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = .clear
        self.navigationItem.removeBackButtonText()
    }
    
    @objc func popNow() {
        self.popViewController(animated: true)
    }
    
    func black() {
        let image = UIImage()
        self.navigationBar.setBackgroundImage(image.with(color: UIColor.black), for: UIBarMetrics.default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.black
    }
    
}

extension UILabel {
    func standardizeSectionHeader() {
        self.kern(value: 1.2, text: self.text ?? "")
    }
    
    func standardizeTextFieldHeader() {
//        self.kern(value: 1.7, text: self.text ?? "")
    }
    
    func kern(value: CGFloat, text: String) {
        if text != "" {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            self.attributedText = attributedString
        }
    }
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 1.20) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

extension UIButton {
    
    func kern(value: CGFloat, text: String, isWhite: Bool = false) {
        if text != "" {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            
            if isWhite {
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
            }
            
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    func standardBorder() {
        self.backgroundColor = UIColor.white
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.textFieldBorderLightGrey.cgColor
    }
    
    func standardBottomButton() {
        if self.title(for: .normal) != "" {
            let attributedString = NSMutableAttributedString(string: self.title(for: .normal) ?? "DONE")
//            attributedString.addAttribute(NSAttributedStringKey.kern, value: 2.0, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
            
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    
}

extension Collection where Index == Int {
    
    /**
     Picks a random element of the collection.
     
     - returns: A random element of the collection.
     */
    func random() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
    
}


extension UIDevice {
    
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height >= 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4 = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}

extension UIScrollView {
    func standardizeByScreenSize(yValue: CGFloat = 0) {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            // Make specific layout for small devices.
            self.contentInset = UIEdgeInsets(top: yValue, left: 0, bottom: 265.0, right: 0)
        } else if UIDevice.current.screenType == .iPhones_6_6s_7_8  {
            self.contentInset = UIEdgeInsets(top: yValue, left: 0, bottom: 170.0, right: 0)
        } else if UIDevice.current.screenType == .iPhone4 {
            self.contentInset = UIEdgeInsets(top: yValue, left: 0, bottom: 395.0, right: 0)
        } else if UIDevice.current.screenType == .iPhoneX {
            self.contentInset = UIEdgeInsets(top: yValue, left: 0, bottom: 50.0, right: 0)
        }
    }
}


extension UINavigationItem {
    func removeBackButtonText() {
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 0.0)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.backBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
    
    func setTitle(title:String, subtitle:String) {
        
        let one = UILabel()
        one.text = title
        one.font = UIFont(name: "Gilroy-SemiBold", size: 16)!
        one.textColor = UIColor.white
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont(name: "Gilroy-Medium", size: 13)!
        two.textColor = UIColor.white.withAlphaComponent(0.50)
        two.textAlignment = .center
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        stackView.alignment = .center
        self.titleView = stackView
    }
    
    func rightAlignedTitle(title: String) {
        let longTitleLabel = UILabel()
        longTitleLabel.font = UIFont(name: "Gilroy-Medium", size: 12.0)
        longTitleLabel.kern(value: 3.0, text: title)
        longTitleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.rightBarButtonItem = leftItem
    }
}

extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func removeBottomBorderImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIApplication{
    var topViewController: UIViewController?{
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
    }

}

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indexes")
        insert(remove(at: from), at: to)
    }
}


extension UIViewController {
    func presentSimpleAlert(withTitle title: String, andMessage message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    func presentSimpleAlertWithCompletions(withTitle title: String, okButton: String, cancelButton: String, andMessage message: String, okCompletion: @escaping(() -> Void), cancelCompletion: @escaping(() -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelButton != "" {
            alertController.addAction(UIAlertAction(title: cancelButton, style: .destructive, handler: { (action) in
                cancelCompletion()
            }))
        }
        alertController.addAction(UIAlertAction(title: okButton, style: .default, handler: { (action) in
            okCompletion()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }

    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }

        badgeLayer?.removeFromSuperlayer()

        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)

        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)

        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }

    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}

extension AVAsset {
    
    var videoThumbnail:UIImage? {
        let assetImageGenerator = AVAssetImageGenerator(asset: self)
        assetImageGenerator.appliesPreferredTrackTransform = true
        var time = self.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbNail = UIImage.init(cgImage: imageRef)
            return thumbNail
        } catch {
            return nil
        }
    }
}


extension Sequence {
    func limit(_ max: Int) -> [Element] {
        return self.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }
}


class CustomSlider:UISlider{
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        bounds = bounds.insetBy(dx: -10, dy: -15)
        return bounds.contains(point)
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

class CustomTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


extension Date{
    func getElapsedInterval() -> String {
        let currentLocalTimestamp = Date().timeIntervalSince1970
        let date = Date(timeIntervalSince1970: currentLocalTimestamp)
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: date)
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        }else if let hours = interval.hour, hours > 0{
            let hoursString = "\(hours)"
           // hoursString = (hours < 0) ? hoursString.replacingOccurrences(of: "-", with: "") : hoursString
            return hours == 1 ? hoursString + " " + "hour ago" :
                hoursString + " " + "hours ago"
        }else if let minutes = interval.minute, minutes > 0 {
            return minutes == 1 ? "\(minutes)" + " " + "minute ago" :
                "\(minutes)" + " " + "minutes ago"
        }else{
            return "few moments ago"
        }
    }
}

extension UIImage{
    func addWaterMark(image: UIImage) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height))
        image.draw(in: CGRect(x: self.size.width - 100, y: self.size.height - 100, width: 80, height: 80))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}


class PaddingField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}




extension UIImage {
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            return nil
        }
        return UIImage.animatedImageWithSource(source: source)
    }
    
    public class func gifImageWithURL(gifUrl: String) -> UIImage? {
        guard let bundleURL = NSURL(string: gifUrl)
        else {
            DebugLog.debug("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL as URL) else {
            DebugLog.debug("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
            DebugLog.debug("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL) else {
            DebugLog.debug("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        DebugLog.debug("SwiftGif :  gifImageWithData \(imageData.count)  ***** \((imageData as? [NSData])?.count)")
        
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithJson(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "json") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        print("SwiftGif :  gifImageWithData \(imageData.count)  ***** \((imageData as? [NSData])?.count)")
        
        return gifImageWithData(data: imageData)
    }
    
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        if a! < b! {
            let c = a!
            a = b!
            b = c
        }
        var rest: Int
        while true {
            rest = a! % b!
            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }
    
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
       // print("getting images **** \(count)")
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()
        
        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}
extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
extension String {
    
    func widthOfStringMain(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
