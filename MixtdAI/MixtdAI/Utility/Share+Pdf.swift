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
