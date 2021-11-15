//
//  HomeCoordinator.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation

protocol HomeCoordinatorProtocol: CoordinatorProtocol {
    func seeDetail()
}

class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    override func start() {
        let homeViewController = HomeViewController(viewModel: HomeViewModel(coordinator: self))
        self.rootViewController.pushViewController(homeViewController, animated: true)
    }
    
    func seeDetail() {
        
    }
}

