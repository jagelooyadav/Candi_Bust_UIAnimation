//
//  GameDetailCoordinator.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 16/11/21.
//

import Foundation
import UIKit

protocol GameDetailCoordinatorProtocol: CoordinatorProtocol {
    func playGame()
}

class GameDetailCoordinator: Coordinator {
    override func start() {
        // Home page journey started
        print("Game detail jouney started")
    }
}

extension GameDetailCoordinator: GameDetailCoordinatorProtocol {
    func playGame() {
        let root = UINavigationController.init()
        let gamePlayerCoordinator = GamePlayerCoordinator(rootViewController: root)
        self.addChildCoordinator(gamePlayerCoordinator)
        gamePlayerCoordinator.parentCoordinator = self
        gamePlayerCoordinator.start()
    }
}
