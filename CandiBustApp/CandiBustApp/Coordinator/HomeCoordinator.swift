//
//  HomeCoordinator.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol: CoordinatorProtocol {
    func seeDetail(fromSourceFrame frame: CGRect?)
}

class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    var sourceFrame: CGRect?
    let transition = CandiScreenTransitioner()
    
    override func start() {
        let homeViewController = HomeViewController(viewModel: HomeViewModel(coordinator: self))
        self.rootViewController.pushViewController(homeViewController, animated: true)
    }
    
    func seeDetail(fromSourceFrame frame: CGRect?) {
        self.sourceFrame = frame
        let gameDetailCoordinator = GameDetailCoordinator(rootViewController: self.rootViewController)
        self.addChildCoordinator(gameDetailCoordinator)
        gameDetailCoordinator.parentCoordinator = self
        gameDetailCoordinator.start()
        
        // Present detail view controller and customise presentation animation
        let homeDetailViewController = GameDetailViewController(viewModel: GameDetailViewModel(coordinator: gameDetailCoordinator))
        homeDetailViewController.transitioningDelegate = self
        homeDetailViewController.modalPresentationStyle = .overFullScreen
        self.rootViewController.viewControllers.last?.present(homeDetailViewController, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension HomeCoordinator: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard
        let sourceFrame = self.sourceFrame
      else {
        return nil
    }
    
    transition.originFrame = sourceFrame
    transition.originFrame = CGRect(
      x: transition.originFrame.origin.x,
      y: transition.originFrame.origin.y,
      width: transition.originFrame.size.width,
      height: transition.originFrame.size.height
    )
    
    transition.presenting = true
    
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}


