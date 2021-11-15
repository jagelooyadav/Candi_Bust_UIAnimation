//
//  GameCell.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

class GameCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    var viewModel: GameCelViewModelProtocol? {
        didSet {
            self.update()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        let container = UIView()
        container.backgroundColor = .orange
        container.layer.cornerRadius = 20.0
        self.contentView.addSubview(container)
        container.anchorToSuperView(bottomRelation: .greaterOrEqual, leading: 25.0, trailing: 25.0, bottom: 25.0)
        if let window = UIApplication.shared.windows.last {
            container.heightAnchor.constraint(equalToConstant: window.frame.height * 0.6).isActive = true
        }
    }
    
    private func update() {
        // Update cell attributes here from view model
    }
}
