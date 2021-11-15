//
//  AppCoodinator.swift
//  PhoneEstimator
//
//  Created by Jageloo Yadav on 03/10/21.
//  Copyright © 2021 Jageloo. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: CoordinatorProtocol {
    func start()
}

class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    override func start() {
        print("app is started")
        let homeCoordinator = HomeCoordinator(rootViewController: self.rootViewController)
        self.addChildCoordinator(homeCoordinator)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
    }
}
