//
//  AccountViewPresenter.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 18/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import Geth

protocol AccountViewPresenterProtocol: class {
    func displayEthereumAccountBalance(ethereumWallet: EthereumWallet)
    func displaySynsStatus(syncStatus: SyncStatusModel)
}

class AccountViewPresenter {
    
    weak private var accountViewDelegate: AccountViewPresenterProtocol?
    private let geth: GethService
    private let web3: Web3Service

    init(geth:GethService, web3: Web3Service) {
        self.geth = geth
        self.web3 = web3
    }
    
    func setViewDelegate(accountViewDelegate: AccountViewPresenterProtocol)  {
        self.accountViewDelegate = accountViewDelegate
    }
    
    func fetchAccountBalance(privateKey: String) {
        if let delegate = accountViewDelegate {
            guard let accountAddress = web3.getAccountAddress(privateKey: privateKey) else { return }
            let wallet = geth.getBalanceAt(accountAddress: accountAddress)
            delegate.displayEthereumAccountBalance(ethereumWallet: wallet)
        }
     }
    
    func fetchSyncStatus()  {
        if let delegate = accountViewDelegate {
            let syncStatus = geth.getSynsStatus()
            delegate.displaySynsStatus(syncStatus: syncStatus)
        }
    }
}
