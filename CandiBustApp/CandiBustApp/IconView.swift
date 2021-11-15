//
//  IconView.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

class IconView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .yellow
        self.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.widthAnchor.constraint(equalToConstant: 90).isActive = true
        self.layer.cornerRadius = 10.0
    }
}
