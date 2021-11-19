//
//  PlayerReadyStateView.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation
import UIKit

class PlayerReadyStateView: UIView {
    let circleGhost = UIStackView()
    private let ballanceDescriptionView = UIView()
    let gameNameLabel = UILabel()
    let container = UIStackView()
    let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //Ready to play label
        label.text = "Ready to Play?"
        self.addSubview(label)
        label.anchorToSuperView(leadingRelation: .greaterOrEqual,
                                trailingRelation: .greaterOrEqual,
                                bottomRelation: .ignore,
                                top: 20.0)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
        gameNameLabel.text = "OSWALD"
        
        self.addSubview(gameNameLabel)
        gameNameLabel.anchorToSuperView(topAnchor: label.bottomAnchor,
                                        leadingRelation: .greaterOrEqual,
                                        trailingRelation: .greaterOrEqual,
                                        bottomRelation: .ignore, top: 10)
        gameNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        // Add 2 ghost
        container.axis = .horizontal
        container.spacing = 10.0
        let ghost1 = UIView()
        ghost1.backgroundColor = .ghostColor
        let ghost2 = UIView()
        ghost2.backgroundColor = .ghostColor
        container.addArrangedSubview(ghost1)
        container.addArrangedSubview(ghost2)
        ghost1.translatesAutoresizingMaskIntoConstraints = false
        ghost2.translatesAutoresizingMaskIntoConstraints = false
        ghost1.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        ghost1.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        ghost2.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        ghost2.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        self.addSubview(container)
        container.anchorToSuperView(topAnchor: gameNameLabel.bottomAnchor,
                                    leadingRelation: .greaterOrEqual,
                                    trailingRelation: .greaterOrEqual,
                                    bottomRelation: .greaterOrEqual,
                                    top: 10.0)
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.addSubview(circleGhost)
        circleGhost.spacing = 10.0
        circleGhost.anchorToSuperView(topAnchor: container.bottomAnchor,
                                      leadingRelation: .greaterOrEqual,
                                      trailingRelation: .greaterOrEqual,
                                      bottomRelation: .ignore,
                                      top: 20,
                                      bottom: 30.0)
        circleGhost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        circleGhost.axis = .horizontal
        circleGhost.distribution = .fillEqually
        circleGhost.alpha = 0.0
        for _  in 0...2 {
            let circle = UIView()
            circle.backgroundColor = .ghostColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
            circle.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            circle.layer.cornerRadius = 20.0
            let label = UILabel()
            circle.addSubview(label)
            label.anchorToSuperView(topRelation: .ignore, bottomRelation: .ignore)
            label.textAlignment = .center
            label.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true
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
        label.text = "Wallet Balance:"
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
    
    
    private func animateToGhost(completion: (() -> Void)? = nil) {
        self.label.transform = CGAffineTransform(scaleX: 1/180.0, y: 1/30.0)
        self.gameNameLabel.transform = CGAffineTransform(scaleX: 1/90.0, y: 1/30.0)
        self.container.transform = CGAffineTransform(scaleX: 1/120.0, y: 1/20.0)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut) {
            self.label.transform = .identity
            self.gameNameLabel.transform = .identity
            self.container.transform = .identity
        } completion: { _ in
            completion?()
        }
    }
    
    func animate() {
        self.animateToGhost {
            self.animateCicles()
            self.animateBalance()
        }
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
        self.ballanceDescriptionView.transform = CGAffineTransform(scaleX: 1/220.0, y: 1/30.0)
        let center = self.ballanceDescriptionView.center
        self.ballanceDescriptionView.center = CGPoint.init(x: center.x, y: center.y + 60.0)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.ballanceDescriptionView.transform = .identity
            self.ballanceDescriptionView.alpha = 1.0
            self.ballanceDescriptionView.center = center
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
}
