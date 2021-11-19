//
//  WalletBallanceViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation

protocol WalletBallanceViewModelProtocol: class {
    var ballanceString: String { get }
    var wallets: [String] { get }
    var selectedIndex: Int { get set }
    var balanceHeading: String { get }
}

class WalletBallanceViewModel: WalletBallanceViewModelProtocol {
 

    let data: GameWalletData
    
    var selectedIndex = 0
    
    init(data: GameWalletData) {
        self.data = data
    }
    var ballanceString: String {
        return data.ballance
    }
    
    var wallets: [String] {
        return data.wallets.compactMap { $0.value }
    }
    
    var balanceHeading: String {
        "Wallet Balance:"
    }
}

