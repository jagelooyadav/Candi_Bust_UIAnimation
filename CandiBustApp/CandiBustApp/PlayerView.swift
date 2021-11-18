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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.setupTopHeaderGhost()
        }
    }
    
    private func setupTopHeaderGhost() {
        topHeaderGhost.backgroundColor = .ghostColor
        self.addSubview(topHeaderGhost)
        topHeaderGhost.anchorToSuperView(topAnchor: self.topAnchor,
                                         leadingRelation: .greaterOrEqual,
                                         trailingRelation: .greaterOrEqual,
                                         bottomRelation: .ignore,
                                         top: 30.0)
        self.topHeaderGhostWidth = topHeaderGhost.widthAnchor.constraint(equalToConstant: 0)
        self.topHeaderGhostWidth?.isActive = true
        self.topHeaderGhostHeight = topHeaderGhost.heightAnchor.constraint(equalToConstant: 0)
        self.topHeaderGhostHeight?.isActive = true
        
        topHeaderGhost.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layoutIfNeeded()
        startAnimation()
    }
    
    func startAnimation() {
        animateToGhost()
    }
    
    private func animateToGhost(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut) {
            self.topHeaderGhost.transform = .identity
            self.topHeaderGhost.alpha = 1.0
            self.topHeaderGhostWidth?.constant = 150.0
            self.topHeaderGhostHeight?.constant = 30.0
            self.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
}
