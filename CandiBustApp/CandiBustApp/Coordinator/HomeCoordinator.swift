//
//  HomeCoordinator.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol: CoordinatorProtocol {
    func seeDetail(info: CellAnimationInfo)
}

class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    var sourceFrame: CGRect?
    let transition = CandiScreenTransitioner()
    
    override func start() {
        let homeViewController = HomeViewController(viewModel: HomeViewModel(coordinator: self))
        self.rootViewController.pushViewController(homeViewController, animated: true)
    }
    
    func seeDetail(info: CellAnimationInfo) {
        let rootViewController = UINavigationController.init()
        let gameDetailCoordinator = GameDetailCoordinator(rootViewController: rootViewController)
        self.addChildCoordinator(gameDetailCoordinator)
        gameDetailCoordinator.parentCoordinator = self
        gameDetailCoordinator.start()
        
        // Present detail view controller and customise presentation animation
        let homeDetailViewController = GameDetailViewController(viewModel: GameDetailViewModel(coordinator: gameDetailCoordinator))
        rootViewController.modalPresentationStyle = .custom
        rootViewController.navigationBar.isHidden = true
        rootViewController.pushViewController(homeDetailViewController, animated: true)
        rootViewController.transitioningDelegate = self
        homeDetailViewController.modalPresentationStyle = .overFullScreen
        self.rootViewController.viewControllers.last?.present(rootViewController, animated: true, completion: {
            homeDetailViewController.animationInfo = info
            homeDetailViewController.animationCompleted?()
        })
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension HomeCoordinator: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    transition.presenting = true
    
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}


