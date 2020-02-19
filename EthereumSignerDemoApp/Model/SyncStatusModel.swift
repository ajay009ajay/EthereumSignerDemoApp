//
//  SyncStatusModel.swift
//  EthereumSignerDemoApp
//
//  Created by Apple Imac on 19/02/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation


struct SyncStatusModel {
    var isSyncing: Bool = true
    var highestBlock: Int64
    var currentBlock: Int64
    var status: String
}
