//
//  QRCodeGenerator.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 17/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class QRCodeGenerator {
    static let shared = QRCodeGenerator()
    
    func generateQRCode(message: Data) -> UIImage? {
        if let qrFilter = CIFilter(name: "CIQRCodeGenerator") {
            qrFilter.setValue(message, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = qrFilter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
