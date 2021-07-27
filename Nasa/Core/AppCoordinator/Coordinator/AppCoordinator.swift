import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator {
    
    private let appCoordinatorFactory: AppCoordinatorFactory
    
    override init(router: Router, container: DependencyContainer) {
        appCoordinatorFactory = AppCoordinatorFactory(container: container, router: router)
        super.init(router: router, container: container)
    }
    
    override func start() {
        startMainFlow()
    }
    
    private func startMainFlow() {
        let coordinator = appCoordinatorFactory.makeMainCoordinator()
        coordinator.start()
        addDependency(coordinator)
    }
}
