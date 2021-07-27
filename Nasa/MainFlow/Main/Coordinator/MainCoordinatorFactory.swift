//
//  MainCoordinatorFactory.swift
//  Nasa
//
//  Created by kairzhan on 7/27/21.
//

import UIKit

class MainCoordinatorFactory {
    private let container: DependencyContainer
    private let router: Router
    
    init(container: DependencyContainer, router: Router) {
        self.container = container
        self.router = router
    }
    
    func makeMain() -> MainModule {
        let apiService = container.resolve(ApiService.self)!
        let viewModel = MainViewModel(apiService: apiService)
        return MainViewController(viewModel: viewModel) 
    }
}

