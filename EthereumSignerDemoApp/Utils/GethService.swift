//
//  GethService.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 19/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import Geth
import BigInt
import XCGLogger

class GethService {
    
    private var gethClient: GethEthereumClient?
    let logger = XCGLogger.default

     init() {
        initNode()
    }


    private func initNode() {
        var error: NSError?
        let bootnodes = GethNewEnodesEmpty()
    bootnodes?.append(GethNewEnode("enode://6e5a52f310aea2abce4e01138cc934ffeca923c45939818104273994f12c4d1f51a423a00cd564525c51530a52b842269e38ad1c211e209fbfc4715bd560a8b4@52.169.42.101:30303", &error))
        
        let config = GethNewNodeConfig()
        config?.ethereumNetworkID = EthereumNetworkId.rinkeby.rawValue
        config?.ethereumGenesis = EthereumNetworkId.rinkeby.ethereumGenesisBlock
        let gethNode  = GethNewNode(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/" + "Rinkeby", config, &error)
         
        try? gethNode?.start()
        gethClient = try? gethNode?.getEthereumClient()
          do {
                try gethNode?.start()
            } catch let err {
                logger.debug("error: \(err.localizedDescription)")
            }
    }
    
    func getBalanceAt(accountAddress: String)-> EthereumWallet  {

                var error: NSError?
                let address = GethNewAddressFromHex(accountAddress, &error) //0x64221f75cC9b3d5cF91D1f22b4d3376acd9428DC  0x2B77B8989aeC6f657D390bD62D7ec625dA63635f
                       // print("Address: \(address?.getHex())")
                var balance: GethBigInt?
                do {
                        balance = try gethClient?.getBalanceAt(GethNewContext(), account: address!, number: -1)
                } catch let err{
                    logger.debug("Error in Getbalance: \(err.localizedDescription)")
                    return EthereumWallet(address: accountAddress, balance:nil, note: "Synchronization initiating")
                }
        
                if let accountBalance = balance {
                    let intVal2 =   accountBalance.getString(10)
                    let valDouble = Double(intVal2)
                    let powVal = pow(10.0, 18.0)
                    let ether = (valDouble ?? 0.0)/powVal
                    return EthereumWallet(address: accountAddress, balance: "\(ether) ETH", note: nil)
                }
            return EthereumWallet(address: accountAddress, balance:nil, note: "balance nil, probably syncing")
        }
    
    func getSynsStatus()-> SyncStatusModel {
        do {
            let sync = try gethClient?.syncProgress(GethNewContext())

            logger.debug("Current block \(String(describing: sync?.getCurrentBlock()))")
            logger.debug("highest block \(String(describing: sync?.getHighestBlock()))")
            logger.debug("highest block \(String(describing: sync?.getKnownStates()))")
            
            let currentBlock: Int64 = sync?.getCurrentBlock() ?? 0
            let highestBlock: Int64  = sync?.getHighestBlock() ?? 0
            let syncing =  (highestBlock - currentBlock) > 0
            let syncMessage = syncing ? "Syncing in progresss." : ""
            return SyncStatusModel(isSyncing: syncing, highestBlock: highestBlock, currentBlock: currentBlock, status: syncMessage)
        } catch let err{
            logger.debug("Sync exception \(err.localizedDescription)")
        }
        /*
           SyncProgress is throwing exception if it is not in progress that might happens if sync has been completed.
           That's why we will hit account balance api
         */
       return SyncStatusModel(isSyncing: false, highestBlock: 0, currentBlock: 0, status: "Probably syncing completed")

    }
}
