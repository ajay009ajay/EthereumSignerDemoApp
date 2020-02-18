//
//  AlertViewHelper.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 17/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import UIKit

class AlertViewHelper {
    
    enum AlertMessage: String {
        case successMessage = "Signature is valid"
        case failMessage = "Signature is invalid"
    }
    
    enum AlertTitle: String {
        case success = "Success"
        case warning = "Warning"
        case error = "Error"
    }
    
     static func showAlert(title: String, message: String, fromController: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertAction.Style.default,
                                                handler: nil))
        fromController.present(alertController, animated: true, completion: nil)
    }
    
    static func showSuccessAlert(fromController: UIViewController) {
        showAlert(title: AlertTitle.success.rawValue,
                  message: AlertMessage.successMessage.rawValue,
                  fromController: fromController)
    }
    
    static func showFailureAlert(fromController: UIViewController) {
        showAlert(title: AlertTitle.error.rawValue,
                  message: AlertMessage.failMessage.rawValue,
                  fromController: fromController)
    }
}
