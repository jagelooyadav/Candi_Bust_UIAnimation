//
//  ViewController.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
    }
    
    private func setupViews() {
        let titleLabel = UILabel()
        titleLabel.text = self.viewModel.title
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        titleLabel.anchorToSuperView(topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomRelation: .ignore, top: 10.0)
        
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.anchorToSuperView(topAnchor: titleLabel.bottomAnchor, top: 20, bottom: 20.0)
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GameCell.self, forCellReuseIdentifier: "GameCell")
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell")
        return cell!
    }
}
