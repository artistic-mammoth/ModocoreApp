//
//  TimerCoordinator.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 17.09.2023.
//

import UIKit

protocol TimerCoordinatorProtocol: BaseCoordinatorProtocol, Lifecycleable {
    func startTimer(with session: SessionSetup)
    func requestForUpdateHomeView()
}

final class TimerCoordinator {
    // MARK: - Private properties
    private weak var appCoordinator: AppCoordinatorProtocol?
    private var coreDataStack: CoreDataStackProtocol
    private var modulesfactory: CoordinatorsFactoryProtocol
    private var navigationController: UINavigationController
    private var presenter: TimerPresenterProtocol?
    
    // MARK: - Init
    init(appCoordinator: AppCoordinatorProtocol? = nil, coreDataStack: CoreDataStackProtocol, modulesfactory: CoordinatorsFactoryProtocol, navigationController: UINavigationController) {
        self.appCoordinator = appCoordinator
        self.coreDataStack = coreDataStack
        self.modulesfactory = modulesfactory
        self.navigationController = navigationController
    }
}

// MARK: - TimerCoordinatorProtocol
extension TimerCoordinator: TimerCoordinatorProtocol {
    func start() -> UIViewController {
        let viewController = TimerViewController()
        let storage = HistoryStorageService(coreDataStack: coreDataStack)
        let audioService = AudioService()
        let counterService = CounterService(storage: storage, audioService: audioService)
        let presenter = TimerPresenter(view: viewController, counterService: counterService, coordinator: self)
        counterService.delegate = presenter
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: false)
        
        self.presenter = presenter
        return navigationController
    }
    
    func startTimer(with session: SessionSetup) {
        presenter?.startTimer(with: session)
    }
    
    func requestForUpdateHomeView() {
        appCoordinator?.requestForUpdateHomeView()
    }
    
    func appEnterBackground() {
        presenter?.appEnterBackground()
    }
    
    func appEnterForeground() {
        presenter?.appEnterForeground()
    }
}
