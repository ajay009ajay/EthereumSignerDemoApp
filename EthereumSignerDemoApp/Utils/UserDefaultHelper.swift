//
//  UserDefaultHelper.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 17/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

class UserDefaultHelper {
    
    enum UserDefaultKey: String {
        case privateKey = "privateKey"
        case signedMessage = "signedMessage"
    }
    
    static func savePrivateKey(privateKey: String) {
        UserDefaults.standard.set(privateKey, forKey: UserDefaultKey.privateKey.rawValue)
    }
    
    static func getStoredPrivateKey()-> String? {
        return UserDefaults.standard.string(forKey: UserDefaultKey.privateKey.rawValue)
    }
    
    static func saveSignedMessage(signedMessage: String) {
           UserDefaults.standard.set(signedMessage, forKey: UserDefaultKey.signedMessage.rawValue)
       }
       
    static func getSignedMessage()-> String? {
           return UserDefaults.standard.string(forKey: UserDefaultKey.signedMessage.rawValue)
       }
}
