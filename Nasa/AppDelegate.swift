//
//  AppDelegate.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit
import Kingfisher
import Swinject

public let assembler = Assembler([DependencyContainerAssembly()])
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupKingfisher()
        LoggerConfigurator.configure()
        return true
    }
    
    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = CoordinatorNavigationController(backBarButtonImage: nil)
        self.window?.makeKeyAndVisible()
    }
    
    private func makeCoordinator(application: UIApplication) {
        guard let rootController = application.windows.first?.rootViewController as? CoordinatorNavigationController else {
            fatalError("rootViewController must be CoordinatorNavigationController")
        }
        appCoordinator = AppCoordinator(router: Router(rootController: rootController), container: assembler.resolver)
        appCoordinator?.start()
    }
    
    private func setupKingfisher() {
        let cache = ImageCache.default
        cache.memoryStorage.config.expiration = .seconds(30)
        cache.diskStorage.config.expiration = .days(2)
        cache.memoryStorage.config.totalCostLimit = getMB(10)
    }
    
    private func getMB(_ value: Int) -> Int {
        return value * 1024 * 1024
    }
}

