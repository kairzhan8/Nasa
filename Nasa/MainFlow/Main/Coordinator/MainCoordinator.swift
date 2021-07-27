//
//  MainCoordinator.swift
//  Nasa
//
//  Created by kairzhan on 7/27/21.
//

import Foundation

class MainCoordinator: BaseCoordinator {
    private let moduleFactory: MainCoordinatorFactory
    
    override init(router: Router, container: DependencyContainer) {
        moduleFactory = MainCoordinatorFactory(container: container, router: router)
        super.init(router: router, container: container)
    }
    
    override func start() {
        makeMain()
    }
    
    private func makeMain() {
        let module = moduleFactory.makeMain()
        router.setRootModule(module)
    }
}
