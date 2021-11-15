//
//  Coordinator.swift
//  PhoneEstimator
//
//  Created by Jageloo Yadav on 03/10/21.
//  Copyright © 2021 Jageloo. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: class {
    var rootViewController: UINavigationController { get }
    var childCoordinators: [CoordinatorProtocol] { get }
    var parentCoordinator: CoordinatorProtocol? { get set }
    func finish()
    func start()
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol)
}

class Coordinator: CoordinatorProtocol {
    var rootViewController: UINavigationController
    weak var parentCoordinator: CoordinatorProtocol?
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        for index in 0..<childCoordinators.count {
            if type(of: childCoordinators[index])  == type(of: coordinator) {
                childCoordinators.remove(at: index)
            }
        }
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func finish() {
        self.childCoordinators.removeAll()
        self.parentCoordinator?.removeChildCoordinator(self)
    }
    
    func start() {
    }
}
