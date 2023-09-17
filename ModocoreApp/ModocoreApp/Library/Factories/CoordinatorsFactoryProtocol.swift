//
//  CoordinatorsFactoryProtocol.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 17.09.2023.
//

import UIKit

protocol CoordinatorsFactoryProtocol: AnyObject {
    func buildAppCoordinator() -> AppCoordinatorProtocol
    func buildHomeCoordinator() -> HomeCoordinatorProtocol
    func buildTimerCoordinator() -> TimerCoordinatorProtocol
}

final class CoordinatorsFactory {
    // MARK: - Private properties
    private var coreDataStack: CoreDataStackProtocol
    private weak var appCoordinator: AppCoordinatorProtocol?
    
    // MARK: - Init
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
}

// MARK: - CoordinatorsFactoryProtocol
extension CoordinatorsFactory: CoordinatorsFactoryProtocol {
    func buildAppCoordinator() -> AppCoordinatorProtocol {
        let appCoordinator = AppCoordinator(tabBarController: TabBarController(),
                                            coreDataStack: coreDataStack,
                                            modulesfactory: self)
        
        self.appCoordinator = appCoordinator
        return appCoordinator
    }
    
    func buildHomeCoordinator() -> HomeCoordinatorProtocol {
        HomeCoordinator(appCoordinator: appCoordinator,
                        coreDataStack: coreDataStack,
                        modulesfactory: self,
                        navigationController: UINavigationController())
    }
    
    func buildTimerCoordinator() -> TimerCoordinatorProtocol {
        TimerCoordinator(appCoordinator: appCoordinator,
                         coreDataStack: coreDataStack,
                         modulesfactory: self,
                         navigationController: UINavigationController())
    }
}
