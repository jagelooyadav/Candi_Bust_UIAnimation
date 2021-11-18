//
//  Button.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

enum ButtonStyle {
    case style1
    case style2
}

/**
 Styled button component  with progress bar functionality
 */

class ProgressBarButton: UIButton {
    private let progressBar = UIButton()
    private var heightConstraint: NSLayoutConstraint?
    private var progressBarWidth: NSLayoutConstraint?
    
    /// Button corner radius can be updated with this
    var radius: CGFloat = 30.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    /// Sets progress value label
    var progressValueLabel: String = "" {
        didSet {
            self.title = self.progressValueLabel
        }
    }
    
    
    /// Update progress colour
    var progressColour: UIColor = UIColor.green {
        didSet {
            self.progressBar.backgroundColor = progressColour
        }
    }
    
    
    /// Progress bar progress in percentage value from 0.0-1.0
    var progress: CGFloat = 0.0 {
        didSet {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            self.progressBarWidth?.constant = self.frame.width * progress
            if progress > 0 {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.1)
            } else {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
            }
        }
    }
    
    /// Action call back for click event
    var action: (() -> Void)?
    
    
    /// Button height setter
    var height: CGFloat = 60.0 {
        didSet {
            if let heightConstraint = self.heightConstraint {
                heightConstraint.constant = height
            } else {
                self.heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
                self.heightConstraint?.isActive = true
            }
        }
    }
    
    
    /// Button title
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
            self.progressBar.setTitle(title, for: .normal)
        }
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    var style: ButtonStyle = .style1 {
        didSet {
            let colour = { () -> UIColor  in
                switch self.style {
                    case .style1:
                        return .green
                    case .style2:
                        return .blue
                }
            }
            self.backgroundColor = colour()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: 60.0)
        self.heightConstraint?.isActive = true
        self.titleLabel?.numberOfLines = 0
        self.addSubview(progressBar)
        self.progressBarWidth = self.progressBar.widthAnchor.constraint(equalToConstant: 0.0)
        self.progressBarWidth?.constant = 0
        self.progressBar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        progressBar.anchorToSuperView(trailingRelation: .ignore)
        self.clipsToBounds = true
        self.progressBarWidth?.isActive = true
        self.progressBar.backgroundColor = .blue
        self.bringSubviewToFront(self.titleLabel!)
        self.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc private func click() {
        self.action?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = radius
        self.progressBar.layer.cornerRadius = radius
    }
}
