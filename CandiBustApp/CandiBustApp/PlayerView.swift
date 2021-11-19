//
//  PlayerView.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation
import UIKit

enum PlayerState {
    case initial
    case balance
    case ready
}

class PlayerView: UIView {
    private let nextButton = ProgressBarButton()
    private let topHeaderGhost = UIView()
    private var topHeaderGhostWidth: NSLayoutConstraint?
    private var topHeaderGhostHeight: NSLayoutConstraint?
    private let item1Ghost = ItemGhost()
    private let item2Ghost = ItemGhost()
    
    var state: PlayerState = .initial
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        nextButton.style = .style1
        self.addSubview(nextButton)
        nextButton.anchorToSuperView(topRelation: .ignore, leading: 25.0, trailing: 25.0, bottom: 25.0)
        nextButton.height = 60.0
        nextButton.title = "Next"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.setupTopHeaderGhost()
            self.setupItemGhost()
        }
        nextButton.action = { [weak self] in
            if self?.state == .initial {
                self?.state = .balance
                self?.showBalanceView()
            }
            if self?.state == .balance {
                self?.state = .ready
                self?.openReadyState()
            }
        }
    }
    
    func openReadyState() {
        
    }
    
    private func showBalanceView() {
        let ballanceView = WalletBallanceView(viewModel: WalletBallanceViewModel(data: GameWalletData(ballance: "$30.0",
                                                                                                      wallets: [Wallet(value: "5"),
                                                                                                                Wallet(value: "10"),
                                                                                                            Wallet(value: "15")])))
        self.addSubview(ballanceView)
        ballanceView.anchorToSuperView(bottomRelation: .ignore)
        ballanceView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20.0).isActive = true
        self.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            ballanceView.animate()
        }
    }
    
    private func setupTopHeaderGhost() {
        topHeaderGhost.backgroundColor = .ghostColor
        self.addSubview(topHeaderGhost)
        topHeaderGhost.anchorToSuperView(topAnchor: self.topAnchor,
                                         leadingRelation: .greaterOrEqual,
                                         trailingRelation: .greaterOrEqual,
                                         bottomRelation: .ignore,
                                         top: 40.0)
        self.topHeaderGhostWidth = topHeaderGhost.widthAnchor.constraint(equalToConstant: 0)
        self.topHeaderGhostWidth?.isActive = true
        self.topHeaderGhostHeight = topHeaderGhost.heightAnchor.constraint(equalToConstant: 0)
        self.topHeaderGhostHeight?.isActive = true
        
        topHeaderGhost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layoutIfNeeded()
    }
    
    private func setupItemGhost() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.distribution = .fillEqually
        stack.addArrangedSubview(item1Ghost)
        stack.addArrangedSubview(item2Ghost)
        self.addSubview(stack)
        stack.anchorToSuperView(topAnchor: topHeaderGhost.bottomAnchor,
                                leadingRelation: .ignore,
                                trailingRelation: .ignore,
                                bottomRelation: .ignore, top: 15.0)
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layoutIfNeeded()
        startAnimation()
    }
    
    func startAnimation() {
        animateToGhost()
        item1Ghost.animate()
        item2Ghost.animate()
    }
    
    private func animateToGhost(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut) {
            self.topHeaderGhost.transform = .identity
            self.topHeaderGhost.alpha = 1.0
            self.topHeaderGhostWidth?.constant = self.frame.width * 0.4
            self.topHeaderGhostHeight?.constant = 30.0
            self.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
}

private class ItemGhost: UIView {
    private let circleGohost = UIView()
    private let middleGhost = UIView()
    private let bottomGhost = UIView()
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        circleGohost.backgroundColor = .ghostColor
        self.addSubview(circleGohost)
        circleGohost.anchorToSuperView(leadingRelation: .greaterOrEqual,
                                       trailingRelation: .greaterOrEqual,
                                       bottomRelation: .ignore)
        circleGohost.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        circleGohost.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        circleGohost.layer.cornerRadius = 40.0
        circleGohost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        middleGhost.backgroundColor = .ghostColor
        self.addSubview(middleGhost)
        middleGhost.anchorToSuperView(topAnchor: circleGohost.bottomAnchor,
                                      bottomRelation: .ignore, top: 15.0)
        middleGhost.widthAnchor.constraint(equalToConstant: 110).isActive = true
        middleGhost.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        middleGhost.centerXAnchor.constraint(equalTo: circleGohost.centerXAnchor).isActive = true
        self.addSubview(bottomGhost)
        bottomGhost.backgroundColor = .ghostColor
        bottomGhost.anchorToSuperView(topAnchor: middleGhost.bottomAnchor,
                                      leadingRelation: .ignore,
                                      trailingRelation: .ignore, top:  15.0)
        bottomGhost.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        bottomGhost.widthAnchor.constraint(equalTo: middleGhost.widthAnchor, multiplier: 0.8).isActive = true
        bottomGhost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func animate() {
        guard let superView = self.superview else { return }
        self.circleGohost.alpha = 0.0
        middleGhost.transform = CGAffineTransform(translationX: superView.frame.width + 90, y: 0)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0.5, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.middleGhost.transform = .identity
            self.layoutIfNeeded()
        } completion: { _ in
        }
        
        bottomGhost.transform = CGAffineTransform(translationX: superView.frame.width + 110, y: 0)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, delay: 0.5, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.bottomGhost.transform = .identity
            self.layoutIfNeeded()
        } completion: { _ in
            
        }
        
        self.circleGohost.transform = CGAffineTransform(translationX: superView.frame.width + 100, y: 0)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.circleGohost.transform = .identity
            self.circleGohost.alpha = 1.0
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
}

class WalletBallanceView: UIView {
    
    let viewModel: WalletBallanceViewModelProtocol
    
    private let topGohost = UIView()
    private var topGohostWidth: NSLayoutConstraint?
    private var topGohostHeight: NSLayoutConstraint?
    private let middleGhost = UIView()
    private let bottomGhost = UIView()
    private let circleGhost = UIStackView()
    private let ballanceDescriptionView = UIView()
    
    private var middleGohostWidth: NSLayoutConstraint?
    private var middleGohostHeight: NSLayoutConstraint?
    
    init(viewModel: WalletBallanceViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        self.backgroundColor = .white
        topGohost.backgroundColor = .ghostColor
        self.addSubview(topGohost)
        topGohost.anchorToSuperView(leadingRelation: .greaterOrEqual,
                                       trailingRelation: .greaterOrEqual,
                                       bottomRelation: .ignore,
                                       top: 30.0)
        topGohostHeight = topGohost.heightAnchor.constraint(equalToConstant: 0.0)
        topGohostWidth = topGohost.widthAnchor.constraint(equalToConstant: 0.0)
        topGohostHeight?.isActive = true
        topGohostWidth?.isActive = true
        topGohost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        ///
        middleGhost.backgroundColor = .ghostColor
        self.addSubview(middleGhost)
        middleGhost.anchorToSuperView(topAnchor: topGohost.bottomAnchor,
                                    leadingRelation: .greaterOrEqual,
                                    trailingRelation: .greaterOrEqual,
                                    bottomRelation: .ignore,
                                    top: 30.0)
        middleGohostHeight = middleGhost.heightAnchor.constraint(equalToConstant: 0.0)
        middleGohostWidth = middleGhost.widthAnchor.constraint(equalToConstant: 0.0)
        middleGohostHeight?.isActive = true
        middleGohostWidth?.isActive = true
        middleGhost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        circleGhost.backgroundColor = .clear
        circleGhost.spacing = 20.0
        self.addSubview(circleGhost)
        circleGhost.anchorToSuperView(topAnchor: middleGhost.bottomAnchor,
                                      leadingRelation: .greaterOrEqual,
                                      trailingRelation: .greaterOrEqual,
                                      bottomRelation: .ignore,
                                      top: 10,
                                      bottom: 30.0)
        circleGhost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        circleGhost.axis = .horizontal
        circleGhost.distribution = .fillEqually
        circleGhost.alpha = 0.0
        viewModel.selectedIndex = 0
        for (index, wallet) in self.viewModel.wallets.enumerated() {
            let circle = UIView()
            circle.backgroundColor = viewModel.selectedIndex == index ? .green : .ghostColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
            circle.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
            circle.layer.cornerRadius = 30.0
            let label = UILabel()
            circle.addSubview(label)
            label.anchorToSuperView(topRelation: .ignore, bottomRelation: .ignore)
            label.textAlignment = .center
            label.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
            label.text = wallet
            label.textColor = .white
            circleGhost.addArrangedSubview(circle)
        }
        addbalanceView()
    }
    
    private func addbalanceView() {
        self.addSubview(ballanceDescriptionView)
        ballanceDescriptionView.anchorToSuperView(topAnchor: circleGhost.bottomAnchor,
                                                  trailingRelation: .greaterOrEqual,
                                                  bottomRelation: .greaterOrEqual,
                                                  leading: 40, top: 20.0, bottom: 30)
        let label = UILabel()
        label.text = viewModel.balanceHeading
        ballanceDescriptionView.addSubview(label)
        label.anchorToSuperView(trailingRelation: .ignore,
                                topRelation: .ignore,
                                bottomRelation: .ignore)
        let ghost = UIView()
        ghost.backgroundColor = .ghostColor
        ballanceDescriptionView.addSubview(ghost)
        ghost.anchorToSuperView(leadingAnchor: label.trailingAnchor, leading: 10.0)
        ghost.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        ghost.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        ghost.centerYAnchor.constraint(equalTo: ballanceDescriptionView.centerYAnchor).isActive = true
        ballanceDescriptionView.alpha = 0.0
    }
    
    func animate() {
        self.animateToGhost(completion: {
            self.animateCicles()
            self.animateBalance()
        })
    }
    
    private func animateCicles() {
        guard let superView = self.superview else { return }
        self.circleGhost.transform = CGAffineTransform(translationX: superView.frame.width + 100, y: 0)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.circleGhost.transform = .identity
            self.circleGhost.alpha = 1.0
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
    
    private func animateBalance() {
        guard let superView = self.superview else { return }
        self.ballanceDescriptionView.transform = CGAffineTransform(translationX: -superView.frame.width - 100, y: 0)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.ballanceDescriptionView.transform = .identity
            self.ballanceDescriptionView.alpha = 1.0
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
    
    private func animateToGhost(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut) {
            self.topGohost.alpha = 1.0
            self.topGohostWidth?.constant = self.frame.width * 0.4
            self.topGohostHeight?.constant = 30.0
            
            self.middleGhost.alpha = 1.0
            self.middleGohostWidth?.constant = self.frame.width * 0.3
            self.middleGohostHeight?.constant = 20.0
            self.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
}
