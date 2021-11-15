//
//  HomeViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation

protocol HomeViewModelProtocol: class {
    var coordinator: HomeCoordinatorProtocol? { get set }
    var title: String { get }
    var numberOfEntries: Int { get }
}

class HomeViewModel: HomeViewModelProtocol {
    weak var coordinator: HomeCoordinatorProtocol?
    
    init(coordinator: HomeCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    var title: String { "PLAY" }
    
    var numberOfEntries: Int { 2 }
}
