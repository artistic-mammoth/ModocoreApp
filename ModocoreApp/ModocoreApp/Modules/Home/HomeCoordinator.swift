//
//  HomeCoordinator.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 17.09.2023.
//

import UIKit

protocol HomeCoordinatorProtocol: BaseCoordinatorProtocol {
    func openSetupView(_ callback: @escaping ((SessionSetup) -> Void))
    func startTimer(session: SessionSetup)
    func updateHomeView()
}

final class HomeCoordinator {
    // MARK: - Private properties
    private weak var appCoordinator: AppCoordinatorProtocol?
    private var coreDataStack: CoreDataStackProtocol
    private var modulesfactory: CoordinatorsFactoryProtocol
    private var navigationController: UINavigationController
    private var presenter: HomePresenterProtocol?
    
    // MARK: - Init
    init(appCoordinator: AppCoordinatorProtocol? = nil, coreDataStack: CoreDataStackProtocol, modulesfactory: CoordinatorsFactoryProtocol, navigationController: UINavigationController) {
        self.appCoordinator = appCoordinator
        self.coreDataStack = coreDataStack
        self.modulesfactory = modulesfactory
        self.navigationController = navigationController
    }
}

// MARK: - HomeCoordinatorProtocol
extension HomeCoordinator: HomeCoordinatorProtocol {
    func start() -> UIViewController {
        let viewController = HomeViewController()
        let storage = HistoryStorageService(coreDataStack: coreDataStack)
        let presenter = HomePresenter(view: viewController, coordinator: self, storage: storage)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: false)
        
        self.presenter = presenter
        return navigationController
    }
    
    func openSetupView(_ callback: @escaping ((SessionSetup) -> Void)) {
        let setupViewController = SetupViewController()
        setupViewController.pickedCallback = { callback($0) }
        navigationController.present(setupViewController, animated: true)
    }
    
    func startTimer(session: SessionSetup) {
        appCoordinator?.startTimer(with: session)
    }
    
    func updateHomeView() {
        presenter?.updateHomeView()
    }
}
