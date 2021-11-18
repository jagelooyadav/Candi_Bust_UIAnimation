//
//  GamePlayerCoordinator.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation
import UIKit

protocol GamePlayerCoordinatorProtocol: CoordinatorProtocol {
}

class GamePlayerCoordinator: Coordinator, GamePlayerCoordinatorProtocol {
    override func start() {
        print("Game player jouney started")
        let viewModel = GamePlayerViewModel(coordinator: self)
        let gamePlayerViewController = GamePlayerViewController(viewModel: viewModel)
        self.rootViewController.pushViewController(gamePlayerViewController, animated: false)
        self.rootViewController.navigationBar.isHidden = true
        self.rootViewController.modalPresentationStyle = .overFullScreen
        self.parentCoordinator?.rootViewController.present(self.rootViewController, animated: false, completion: nil)
    }
}
