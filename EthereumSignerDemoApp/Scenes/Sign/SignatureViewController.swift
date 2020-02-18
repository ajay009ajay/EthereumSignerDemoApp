//
//  SignatureViewController.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 16/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {

    @IBOutlet weak var signInMessageLbl: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    private var signatureViewPresenter = SignatureViewPresenter(web3: Web3Service())

    var signingMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = RouterHelper.PageTitle.signature.rawValue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        signatureViewPresenter.setViewDelegate(signatureViewDelegate: self)
        signMessage()
        
    }
    
    func signMessage() {
        signInMessageLbl?.text = #""\#(signingMessage)""#
        signatureViewPresenter.presentSignedQRImage(signingMessage: signingMessage)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SignatureViewController: SignatureViewPresenterProtocol {
    func showQRImage(qrImage: UIImage?) {
        if let qrImage = qrImage {
            qrCodeImageView.image = qrImage
            qrCodeImageView.accessibilityIdentifier = "QRImage"
        }
    }
}
