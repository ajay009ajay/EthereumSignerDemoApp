//
//  ValidateViewController.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 16/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation

class ValidateViewController: UIViewController {

    lazy var qrReaderVC: QRCodeReaderViewController = {
           let builder = QRCodeReaderViewControllerBuilder {
               $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
               $0.showSwitchCameraButton = false
               $0.showTorchButton = false
           }
           
           return QRCodeReaderViewController(builder: builder)
       }()
    
    @IBOutlet weak var verificationMessageTextfield: UITextField!
    @IBOutlet weak var verifyMessagegBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        verificationMessageTextfield.accessibilityIdentifier = "Validate.message.textfield"
        verifyMessagegBtn.accessibilityIdentifier = "Validate.Done.Button"

        customInit()
    }
    
    private func customInit()  {
        self.title = RouterHelper.PageTitle.verification.rawValue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        verificationMessageTextfield.text = UserDefaultHelper.getSignedMessage() ?? ""
        hideKeyboard()
    }
    
    @IBAction func verifyMessageBtnClicked(_ sender: Any) {
        presentQRViewController()
    }
    
    func presentQRViewController() {
        
        guard let textfield = verificationMessageTextfield.text, textfield.count > 0 else {
            AlertViewHelper.showAlert(title: "Validate Error", message: "Please type message for verification", fromController: self)
            return
        }
        
        qrReaderVC.delegate = self
        
        qrReaderVC.modalPresentationStyle = .formSheet
        present(qrReaderVC, animated: true, completion: nil)
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

extension ValidateViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        
        guard let message = verificationMessageTextfield?.text else { return }
        if Web3Service().validateSignedMessage(message: message, qrResultString: result.value) {
            self.dismiss(animated: true) {
                AlertViewHelper.showSuccessAlert(fromController: self)
            }
        } else {
            self.dismiss(animated: true) {
                AlertViewHelper.showFailureAlert(fromController: self)
            }
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}

extension ValidateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presentQRViewController()
        return true
    }
}

