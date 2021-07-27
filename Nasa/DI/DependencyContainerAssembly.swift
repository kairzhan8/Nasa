import Swinject
typealias DependencyContainer = Resolver

public final class DependencyContainerAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(ConfigService.self) { _ in
            ConfigServiceImpl()
        }.inObjectScope(.container)
        ApiServiceAssemblyImpl()
            .registerNetworkLayer(in: container)
        container.register(UIApplication.self) { _ in
            UIApplication.shared
        }.inObjectScope(.container)
        container.register(NotificationCenter.self) { _ in
            NotificationCenter.default
        }.inObjectScope(.container)
    }
}
