//
//  GamePlayerViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation

protocol GamePlayerViewModelProtocol: class {
    
}

class GamePlayerViewModel: GamePlayerViewModelProtocol {
    private weak var coordinator: GamePlayerCoordinatorProtocol?
    
    init(coordinator: GamePlayerCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
