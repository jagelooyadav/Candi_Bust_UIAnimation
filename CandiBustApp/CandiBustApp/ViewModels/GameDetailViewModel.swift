//
//  GameDetailViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 16/11/21.
//

import Foundation

protocol GameDetailViewModelProtocol {
    
}
class GameDetailViewModel: GameDetailViewModelProtocol {
    private weak var coordinator: GameDetailCoordinatorProtocol?
    init(coordinator: GameDetailCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
