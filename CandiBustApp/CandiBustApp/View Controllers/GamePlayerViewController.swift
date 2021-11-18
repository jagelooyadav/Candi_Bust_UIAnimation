//
//  GamePlayerViewController.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation
import UIKit

class GamePlayerViewController: UIViewController {
    
    private let viewModel: GamePlayerViewModelProtocol
    private let playerView = PlayerView()
    private var playerBottomConstraint: NSLayoutConstraint?
    
    init(viewModel: GamePlayerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setupPlayerView()
    }
    
    private func setupPlayerView() {
        self.view.addSubview(playerView)
        playerView.backgroundColor = .white
        let constaints = playerView.anchorToSuperView(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                     topRelation: .ignore)
        playerView.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.5).isActive = true
        let bottomConstraint = constaints.filter { $0.firstAttribute == .bottom }.first
        self.playerBottomConstraint = bottomConstraint
        bottomConstraint?.constant = -view.frame.width * 0.7
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        let childView = UIView()
        childView.backgroundColor = .clear
        view.addSubview(childView)
        childView.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomRelation: .ignore)
        playerView.topAnchor.constraint(equalTo: childView.bottomAnchor).isActive = true
        childView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
     }
    
    @objc func tap() {
        UIView.animate(withDuration: 0.5) {
            self.playerBottomConstraint?.constant = -self.view.frame.width * 0.7
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}