//
//  GamePlayerViewController.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 19/11/21.
//

import Foundation
import UIKit

class GamePlayerViewController: UIViewController {
    private let viewModel: GamePlayerViewModelProtocol
    
    init(viewModel: GamePlayerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
