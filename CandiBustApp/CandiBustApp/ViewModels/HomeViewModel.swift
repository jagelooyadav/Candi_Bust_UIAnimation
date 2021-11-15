//
//  HomeViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation

protocol HomeViewModelProtocol {
    var coordinator: HomeCoordinatorProtocol? { get set }
    var title: String { get }
}

class HomeViewModel: HomeViewModelProtocol {
    weak var coordinator: HomeCoordinatorProtocol?
    
    init(coordinator: HomeCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    var title: String { "Play" }
}
