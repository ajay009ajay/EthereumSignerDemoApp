//
//  Web3Service.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 19/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import Web3swift
import secp256k1_swift
import XCGLogger

class Web3Service {
    
    private let web3Rinkeby = Web3.InfuraRinkebyWeb3()
    let logger = XCGLogger.default

    init() {}
    
    func getAccountAddress(privateKey: String)-> String? {
        guard let privateKeyData = Data.fromHex(privateKey) else { return nil }
        guard let keystore = try? EthereumKeystoreV3(privateKey: privateKeyData) else { return nil }
        let keystoreManager = KeystoreManager([keystore])
        web3Rinkeby.addKeystoreManager(keystoreManager)
        guard let signingAddress = keystore.getAddress()?.address else { return nil }
        return signingAddress
    }
    func signingMessage(message: String, privateKey: String) -> Data? {
        guard let messageData = message.data(using: .utf8) else { return nil }
        guard let signingAddress = getAccountAddress(privateKey: privateKey) else {    return nil  }
        guard let fromAddress = EthereumAddress(signingAddress) else { return nil }
        do {
            let signedData = try web3Rinkeby.personal.signPersonalMessage(message: messageData, from: fromAddress)
            let signedBase64Data = signedData.base64EncodedData()
            UserDefaultHelper.saveSignedMessage(signedMessage: message)
            return signedBase64Data
        } catch {
            print(error)
            return nil
        }
    }

    func validateSignedMessage(message: String, qrResultString: String) -> Bool {
        
        guard let messageData = message.data(using: .utf8) else { return false  }
        guard let privateKey = UserDefaultHelper.getStoredPrivateKey() else { return false }
        guard let signedAddress = getAccountAddress(privateKey: privateKey) else { return false }

        if let signature = Data(base64Encoded: qrResultString),
            let unMarshalledSign = SECP256K1.unmarshalSignature(signatureData: signature) {
            logger.debug("V = " + String(unMarshalledSign.v))
            logger.debug("R = " + Data(unMarshalledSign.r).toHexString())
            logger.debug("S = " + Data(unMarshalledSign.s).toHexString())
            let signer = try? web3Rinkeby.personal.ecrecover(personalMessage: messageData, signature: signature)
            logger.debug("Signer address: \(String(describing: signer?.address)) --- Signed Address: \(String(describing: signedAddress))")
            if (signer?.address == signedAddress) {
                        return true
            } else {
                    return false
            }
        }
        return false
    }
}
