//
//  SetupViewController.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 16/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import Web3swift
import XCGLogger

class SetupViewController: UIViewController {

    @IBOutlet weak var privateKeyTextField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    private let logger = XCGLogger.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        privateKeyTextField.accessibilityIdentifier = "setupVC.privatekey.textfield"
        doneBtn.accessibilityIdentifier = "Setup.Done.Button"
        // Do any additional setup after loading the view.
        customInit()
    }
    
    private func customInit() {
        self.title = RouterHelper.PageTitle.setup.rawValue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        hideKeyboard()
        self.privateKeyTextField?.text = UserDefaultHelper.getStoredPrivateKey() ?? "A84CD98995E775664981AA337646FF3BA7C1B3C29F41A845CED7A15173CA39A7"
    }
    
    func presentAccountVC(privateKey: String) {
        
        guard let privateKeyTextField = privateKeyTextField.text, privateKeyTextField.count == 64 else {
            AlertViewHelper.showAlert(title: "Private Key Error", message: "Private key must be 64 characters or 32 byte of length", fromController: self)
            return
        }
        
        UserDefaultHelper.savePrivateKey(privateKey: privateKey)
        self.performSegue(withIdentifier: RouterHelper.SegueName.accountVC.rawValue, sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        }
    
    //MARK: IBAction
    @IBAction func doneBtnClicked(_ sender: Any) {
        if privateKeyTextField.canResignFirstResponder {
            privateKeyTextField.resignFirstResponder()
        }
        presentAccountVC(privateKey: privateKeyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
    }
}

extension SetupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presentAccountVC(privateKey: textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        return true
    }
}
