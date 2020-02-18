//
//  RouterHelper.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 17/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

class RouterHelper {
    
    enum PageTitle: String {
        case setup = "Setup"
        case account = "Account"
        case signIn =  "SignIng"
        case signature = "Signature"
        case verification = "Verification"
    }
    
    enum SegueName: String {
        case accountVC = "AccountVCSegue"
        case signInVC = "SignMessageSegue"
        case verificationVC = "VerificationMessageSegue"
        case signatureVC = "SignatureVCSegue"
    }
}
