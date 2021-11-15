//
//  HomeViewModel.swift
//  CandiBustApp
//
//  Created by Jageloo Yadav on 15/11/21.
//

import Foundation

/// Protocol abstraction for home view model
protocol HomeViewModelProtocol: class {
    
    /// Coordinator object responsible for screen navigation 
    var coordinator: HomeCoordinatorProtocol? { get set }
    
    /// Screen title displayed on navigation bar
    var title: String { get }
    
    /// Table entries count in home page list view
    var numberOfEntries: Int { get }
}

/// Concrete implmentation for Home View model
final class HomeViewModel: HomeViewModelProtocol {
    weak var coordinator: HomeCoordinatorProtocol?
    
    init(coordinator: HomeCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    var title: String { "PLAY" }
    
    var numberOfEntries: Int { 2 }
}
