//
//  HomeAssembly.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 06.09.2023.
//

import UIKit

final class HomeAssembly {
    static func build(appCoordinator: AppCoordinatorProtocol) -> UIViewController {
        let viewController = HomeViewController()
        let router = HomeRouter(viewController: viewController, appCoordinator: appCoordinator)
        let presenter = HomePresenter(view: viewController, router: router)
        viewController.presenter = presenter
        
        return viewController
    }
}