//
//  PlayerView.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation
import UIKit

class PlayerView: UIView {
    private let nextButton = ProgressBarButton()
    private let topHeaderGhost = UIView()
    private var topHeaderGhostWidth: NSLayoutConstraint?
    private var topHeaderGhostHeight: NSLayoutConstraint?
    private let item1Ghost = ItemGhost()
    private let item2Ghost = ItemGhost()
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
