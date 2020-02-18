//
//  SignViewController.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 16/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {
    @IBOutlet weak var signInMessageTextField: UITextField!
    @IBOutlet weak var signingBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signInMessageTextField.accessibilityIdentifier = "SignIn.message.textfield"
        signingBtn.accessibilityIdentifier = "SignIn.Done.Button"
        UserDefaultHelper.saveSignedMessage(signedMessage: "")
    }
    
    private func customInit() {
        self.title = RouterHelper.PageTitle.signIn.rawValue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        hideKeyboard()
    }

    @IBAction func signInMessageBtnClicked(_ sender: Any) {
        
        guard let textfield = signInMessageTextField.text, textfield.count > 0 else {
            AlertViewHelper.showAlert(title: "Message Error", message: "Please give signing message", fromController: self)
            return
        }
        if signInMessageTextField.canResignFirstResponder {
            signInMessageTextField.resignFirstResponder()
        }
        self.performSegue(withIdentifier: RouterHelper.SegueName.signatureVC.rawValue, sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == RouterHelper.SegueName.signatureVC.rawValue {
            if let signatureVC = segue.destination as? SignatureViewController {
                signatureVC.signingMessage = (signInMessageTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            }
        }
        
    }
}

extension SignViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.canResignFirstResponder {
            textField.resignFirstResponder()
        }
        return true
    }
}
