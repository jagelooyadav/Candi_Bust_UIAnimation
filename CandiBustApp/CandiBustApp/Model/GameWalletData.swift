//
//  GameWalletData.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation

struct GameWalletData: Decodable {
    var ballance: String
    var wallets: [Wallet]
}

struct Wallet: Decodable {
    var value: String
}
