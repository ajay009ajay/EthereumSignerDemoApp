//
//  SignatureViewPresenter.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 18/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import UIKit

protocol SignatureViewPresenterProtocol: class {
    func showQRImage(qrImage: UIImage?)
}

class SignatureViewPresenter {
    
    weak private var signatureViewDelegate: SignatureViewPresenterProtocol?
    private let web3: Web3Service

    init(web3: Web3Service) {
           self.web3 = web3
       }
    
    func setViewDelegate(signatureViewDelegate: SignatureViewPresenterProtocol)  {
        self.signatureViewDelegate = signatureViewDelegate
    }
    
    func presentSignedQRImage(signingMessage: String) {
        if let delegate = signatureViewDelegate {
            guard let privateKey = UserDefaultHelper.getStoredPrivateKey() else { return }
            if let signedData = web3.signingMessage(message: signingMessage, privateKey: privateKey) {
                let qrImage = QRCodeGenerator.shared.generateQRCode(message: signedData)
                delegate.showQRImage(qrImage: qrImage)
            }
        }
     }
}
