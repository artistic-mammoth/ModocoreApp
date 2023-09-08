//
//  TimerAssembly.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 08.09.2023.
//

import UIKit

final class TimerAssembly {
    static func build(appCoordinator: AppCoordinatorProtocol) -> UIViewController {
        let viewController = TimerViewController()
        let storage = HistoryStorageService(coreDataStack: appCoordinator.coreDataStack)
        let counterService = CounterService(storage: storage)
        let presenter = TimerPresenter(view: viewController, counterService: counterService, appCoordinator: appCoordinator)
        counterService.delegate = presenter
        viewController.presenter = presenter
        
        return viewController
    }
}
