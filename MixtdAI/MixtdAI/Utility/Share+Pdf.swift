//
//  Share+Pdf.swift
//  Leaderly
//
//  Created by Aravind Kumar on 20/08/24.
//

import Foundation
import UIKit

extension UIView {
    func exportAsPDF(fileName:String = "mixture.pdf") -> URL? {
        // Step 1: Create a PDF context with the view's size
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        
        // Step 2: Start a new page
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        
        // Step 3: Render the view into the PDF context
        guard let pdfContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: pdfContext)
        
        // Step 4: Close the PDF context
        UIGraphicsEndPDFContext()
        
        // Step 5: Save the PDF to a file
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try pdfData.write(to: fileURL)
            return fileURL
        } catch {
            print("Could not save PDF file: \(error)")
            return nil
        }
    }
}
extension UIScrollView {
    func exportContentAsPDFSS(fileName: String = "mixture.pdf") -> URL? {
        // Step 1: Save original state
        let originalOffset = contentOffset
        let originalFrame = frame

        // Step 2: Set up full content frame for rendering
        let contentSize = self.contentSize
        self.contentOffset = .zero
        self.frame = CGRect(origin: .zero, size: contentSize)

        // Step 3: Set up PDF context
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(origin: .zero, size: contentSize), nil)
        UIGraphicsBeginPDFPageWithInfo(CGRect(origin: .zero, size: contentSize), nil)

        // Step 4: Create black background
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(UIColor.black.cgColor)
        context.fill(CGRect(origin: .zero, size: contentSize))

        // Step 5: Render scrollView onto black background
        self.layer.render(in: context)

        // Step 6: Close context
        UIGraphicsEndPDFContext()

        // Step 7: Restore original state
        self.contentOffset = originalOffset
        self.frame = originalFrame

        // Step 8: Write to file
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        do {
            try pdfData.write(to: fileURL)
            return fileURL
        } catch {
            print("Could not save PDF file: \(error)")
            return nil
        }
    }
}
