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

class Button: UIButton {
    
    private var heightConstraint: NSLayoutConstraint?
    
    var radius: CGFloat = 25.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
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
    
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = radius
    }
}
