//
//  SceneDelegate.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 02.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let coordinator = AppCoordinatorAssembly.build()
        appCoordinator = coordinator
        window?.rootViewController = coordinator.tabBarController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        appCoordinator?.appEnterBackground()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        appCoordinator?.appEnterForeground()
    }
}
