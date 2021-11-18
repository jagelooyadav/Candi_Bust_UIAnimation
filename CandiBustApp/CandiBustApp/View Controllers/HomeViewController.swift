//
//  ViewController.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var tableView: UITableView!
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
    }
    
    private func setupViews() {
        
        titleLabel.text = self.viewModel.title
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        titleLabel.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                     leadingRelation: .ignore,
                                     trailingRelation: .ignore,
                                     bottomRelation: .ignore,
                                     top: 10.0)
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.anchorToSuperView(topAnchor: titleLabel.bottomAnchor, top: 20, bottom: 20.0)
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GameCell.self, forCellReuseIdentifier: "GameCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEntries
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameCell
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        guard let selectedIndexPathCell = tableView.indexPathForSelectedRow,
              let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? GameCell else { return }
        let animationInfo = CellAnimationInfo(iconAbsolutePosition: selectedCell.iconView.superview?.convert(selectedCell.iconView.center, to: view),
                                              butonAbsolutePosition: selectedCell.button.superview?.convert(selectedCell.button.center, to: view),
                                              buttonAbsoluteFrame: selectedCell.superview?.convert(selectedCell.button.frame, from: nil), titleAbsolutePosition: titleLabel.superview?.convert(titleLabel.center, to: view),
                                              titleAbsoluteFrame: titleLabel.superview?.convert(titleLabel.frame, from: nil))
        self.viewModel.coordinator?.seeDetail(info: animationInfo)
    }
}

