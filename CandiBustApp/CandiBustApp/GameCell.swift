//
//  GameCell.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation
import UIKit

class GameCell: UITableViewCell {
    let container = UIView()
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
        container.backgroundColor = .orange
        container.layer.cornerRadius = 20.0
        self.contentView.addSubview(container)
        container.anchorToSuperView(bottomRelation: .greaterOrEqual, leading: 25.0, trailing: 25.0, bottom: 25.0)
        if let window = UIApplication.shared.windows.last {
            container.heightAnchor.constraint(equalToConstant: window.frame.height * 0.6).isActive = true
        }
        self.selectionStyle = .none
        let iconView = IconView()
        container.addSubview(iconView)
        iconView.anchorToSuperView(trailingRelation: .ignore,
                                   bottomRelation: .ignore,
                                   leading: 20, top: 20)
        
        // add green button
        let button = Button()
        button.style = .style1
        container.addSubview(button)
        button.anchorToSuperView(topRelation: .ignore, leading: 25.0, trailing: 25.0, bottom: 25.0)
        button.isUserInteractionEnabled = false
        
    }
    
    private func update() {
        // Update cell attributes here from view model
    }
}
