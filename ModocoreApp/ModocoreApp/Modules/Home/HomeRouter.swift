//
//  HomeRouter.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 06.09.2023.
//

import Foundation

protocol HomeRouterProtocol {
    func openSetupView(_ callback: @escaping ((SessionSetup) -> Void))
    func openTimerViewWith(session: SessionSetup)
}

final class HomeRouter {
    // MARK: - Public properties
    weak var viewController: HomeViewController?
    var appCoordinator: AppCoordinatorProtocol?
    
    init(viewController: HomeViewController? = nil, appCoordinator: AppCoordinatorProtocol? = nil) {
        self.viewController = viewController
        self.appCoordinator = appCoordinator
    }
}

// MARK: - HomeRouterProtocol
extension HomeRouter: HomeRouterProtocol {
    func openTimerViewWith(session: SessionSetup) {
        appCoordinator?.openAndStartTimer(with: session)
    }
    
    func openSetupView(_ callback: @escaping ((SessionSetup) -> Void)) {
        let setupViewController = SetupViewController()
        setupViewController.doneAction = { callback($0) }
        viewController?.navigationController?.present(setupViewController, animated: true)
    }
}
