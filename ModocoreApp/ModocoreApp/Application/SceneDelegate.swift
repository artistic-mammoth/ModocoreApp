//
//  SceneDelegate.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 02.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var lifecycleCoordinator: Lifecycleable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let coordinator = getAppCoordinator()
        lifecycleCoordinator = coordinator as? Lifecycleable
        
        window?.rootViewController = coordinator.start()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        lifecycleCoordinator?.appEnterBackground()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        lifecycleCoordinator?.appEnterForeground()
    }
}

// MARK: - Private extension
private extension SceneDelegate {
    func getAppCoordinator() -> AppCoordinatorProtocol {
        let coreDataStack = CoreDataStack(modelName: "HistoryStorage")
        let factory = CoordinatorsFactory(coreDataStack: coreDataStack)
        let coordinator = factory.buildAppCoordinator()
        return coordinator
    }
}
