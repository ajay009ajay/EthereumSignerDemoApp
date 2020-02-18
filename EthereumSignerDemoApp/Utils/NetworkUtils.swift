//
//  NetworkUtils.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 17/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation
import BigInt
import Geth

public typealias NetworkIDValue = Int64

public enum EthereumNetworkId: NetworkIDValue   {
    case olympic    = 0         // Ethereum prerelease Testnet (OBSOLETE)
    case main       = 1         // Ethereum Main Net (Frontier, Homestead, Metropolis, Serenity)
    case morden     = 2         // Ethereum Morden Testnet (OBSOLETE)
    case ropsten    = 3         // Ethereum Ropsten Testnet (OBSOLETE)
    case rinkeby    = 4         // Ethereum Rinkeby Testnet
    case kovan      = 42        // Ethereum Kovan open parity testnet
    case musicoin   = 7762959   // The music blockchain
}

extension EthereumNetworkId {
    
    var ethereumGenesisBlock: String {
    switch self {
    case .main:
        return GethMainnetGenesis()
    case .rinkeby:
        return GethRinkebyGenesis()
    default:
        return GethMainnetGenesis()
    }
  }
}
