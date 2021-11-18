//
//  GameDetailViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 16/11/21.
//

import Foundation

protocol GameDetailViewModelProtocol {
    var title: String { get }
    var descriptionText: String { get }
    var readMoreTitle: String { get }
}

class GameDetailViewModel: GameDetailViewModelProtocol {
    private weak var coordinator: GameDetailCoordinatorProtocol?
    init(coordinator: GameDetailCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    var title: String {
        "CANDY \n BUST"
    }
    var descriptionText: String {
        "What is Lorem Ipsume? Lorem Ipsum is simply dummy text of the printing and typesetting"
    }
    
    var readMoreTitle: String {
        "READ MORE"
    }
}
