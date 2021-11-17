//
//  GameDetailViewController.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 16/11/21.
//

import Foundation
import UIKit

class GameDetailViewController: UIViewController {
    private let viewModel: GameDetailViewModelProtocol
    
    init(viewModel: GameDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        //self.view.alpha = 0.7
        
        let close = UIButton(type: .custom)
        close.setImage(UIImage(systemName: "multiply"), for: .normal)
        self.view.addSubview(close)
        close.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                leadingRelation: .ignore,
                                bottomRelation: .ignore, trailing: 20.0, top: 10.0)
        close.addTarget(self, action: #selector(self.close), for: .touchUpInside)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
