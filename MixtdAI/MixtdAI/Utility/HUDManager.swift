//
//  HUDManager.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 27/07/25.
//


import SVProgressHUD
import UIKit
import CoreGraphics


class HUDManager {

    // Show the HUD
    static func showHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultMaskType(.clear)  // Set clear mask type to show the HUD without blocking interaction
            SVProgressHUD.show()
        }
    }

    // Hide the HUD
    static func hideHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

    static func mergeImagesWithHalfOverlap(image1: UIImage, image2: UIImage) -> UIImage? {
        let width = max(image1.size.width, image2.size.width)
        let height = max(image1.size.height, image2.size.height)

        let size = CGSize(width: width, height: height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        // Draw the first image
        let image1Rect = CGRect(x: 0, y: 0, width: width / 2, height: height)
        image1.draw(in: image1Rect)

        // Draw the second image
        let image2Rect = CGRect(x: width / 2, y: 0, width: width / 2, height: height)
        image2.draw(in: image2Rect)

        // Blend the overlapping middle part
        let overlapWidth = width / 4
        let image1OverlapRect = CGRect(x: width / 2 - overlapWidth, y: 0, width: overlapWidth, height: height)
        let image2OverlapRect = CGRect(x: width / 2, y: 0, width: overlapWidth, height: height)

        // Draw blended images using alpha
        image1.draw(in: image1OverlapRect, blendMode: .normal, alpha: 0.5)
        image2.draw(in: image2OverlapRect, blendMode: .normal, alpha: 0.5)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return mergedImage
    }

    class func mergeImagesWithSmoothBlend(image1: UIImage, image2: UIImage) -> UIImage? {
        let size = CGSize(width: max(image1.size.width, image2.size.width),
                          height: max(image1.size.height, image2.size.height))

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        // Draw image1 on left
        let halfWidth = size.width / 2
        let rect1 = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image1.draw(in: rect1)

        // Create a gradient mask
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: [UIColor.black.cgColor, UIColor.clear.cgColor] as CFArray,
                                  locations: [0, 1])!

        context.saveGState()
        let blendRect = CGRect(x: halfWidth - 50, y: 0, width: 100, height: size.height)

        context.clip(to: blendRect, mask: image2.cgImage!)

        context.drawLinearGradient(gradient,
                                    start: CGPoint(x: halfWidth - 50, y: 0),
                                    end: CGPoint(x: halfWidth + 50, y: 0),
                                    options: [])

        context.restoreGState()

        // Draw image2 with blend mode
        image2.draw(in: rect1, blendMode: .normal, alpha: 0.5)

        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blendedImage
    }

}
