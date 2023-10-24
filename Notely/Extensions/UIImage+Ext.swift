//
//  UIImage+Ext.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
extension UIImage {
    var isDark: Bool {
        guard let cgImage = self.cgImage else { return false }
        
        // Get the average color of the image.
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(CIImage(cgImage: cgImage), 
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: CIFormat.RGBA8,
                       colorSpace: nil)
        
        let redComponent = CGFloat(bitmap[0]) / 255
        let greenComponent = CGFloat(bitmap[1]) / 255
        let blueComponent = CGFloat(bitmap[2]) / 255
        // Calculate the luminance of the average color.
        let luminance = (0.299 * redComponent + 0.587 * greenComponent + 0.114 * blueComponent)
        
        // Compare the luminance to a threshold value.
        let threshold: CGFloat = 150
        return luminance < threshold
    }
}
