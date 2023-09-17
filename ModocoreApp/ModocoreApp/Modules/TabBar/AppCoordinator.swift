//
//  AppCoordinator.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 08.09.2023.
//

import UIKit

enum Tabs: Int {
    case home
    case timer
    case template
}

protocol AppCoordinatorProtocol: BaseCoordinatorProtocol {
    func switchTabTo(_ tab: Tabs)
    func startTimer(with session: SessionSetup)
    func requestForUpdateHomeView()
}

final class AppCoordinator {
    // MARK: - Private properties
    private var tabBarController: TabBarControllerProtocol
    private var coreDataStack: CoreDataStackProtocol
    private var modulesfactory: CoordinatorsFactoryProtocol
    
    private lazy var homeCoordinator: HomeCoordinatorProtocol = modulesfactory.buildHomeCoordinator()
    private lazy var timerCoordinator: TimerCoordinatorProtocol = modulesfactory.buildTimerCoordinator()
    private lazy var templateController = TemplateViewController()
    
    // MARK: - Init
    init(tabBarController: TabBarControllerProtocol, coreDataStack: CoreDataStackProtocol, modulesfactory: CoordinatorsFactoryProtocol) {
        self.tabBarController = tabBarController
        self.coreDataStack = coreDataStack
        self.modulesfactory = modulesfactory
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    func start() -> UIViewController {
        
        let homeController = homeCoordinator.start()
        let timerController = timerCoordinator.start()
        let templateController = templateController
        
        let homeItem = TabBarItemView(icon: UIImage(systemName: "house.circle"))
        let timerItem = TabBarItemView(icon: UIImage(systemName: "timer.circle.fill"))
        let templateItem = TabBarItemView(icon: UIImage(systemName: "gear.circle"))
        
        let tabs: [TabsItems] = [(homeController, homeItem),
                                 (timerController, timerItem),
                                 (templateController, templateItem)]
        
        tabBarController.setupWith(tabs: tabs)
        
        return tabBarController
    }
    
    func switchTabTo(_ tab: Tabs) {
        tabBarController.switchTabTo(tab.rawValue)
    }
    
    func startTimer(with session: SessionSetup) {
        switchTabTo(.timer)
        timerCoordinator.startTimer(with: session)
    }
    
    func requestForUpdateHomeView() {
        homeCoordinator.updateHomeView()
    }
}

// MARK: - Lifecycleable
extension AppCoordinator: Lifecycleable {
    func appEnterBackground() {
        timerCoordinator.appEnterBackground()
        coreDataStack.saveContext()
    }
    
    func appEnterForeground() {
        timerCoordinator.appEnterForeground()
    }
}
