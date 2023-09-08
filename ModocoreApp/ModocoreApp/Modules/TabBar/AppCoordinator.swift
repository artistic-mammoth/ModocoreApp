//
//  AppCoordinator.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 08.09.2023.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    var tabBarController: TabBarControllerProtocol? { get set }
    var child: [UIViewController]? { get set }
    var coreDataStack: CoreDataStackProtocol { get set }
    func switchTabTo(_ tab: Tabs)
    func openAndStartTimer(with session: SessionSetup)
    func appEnterBackground()
    func appEnterForeground()
    func requestForUpdateUIFromStorage()
}

class AppCoordinator {
    var tabBarController: TabBarControllerProtocol?
    var child: [UIViewController]?
    var coreDataStack: CoreDataStackProtocol
    
    init(tabBarController: TabBarControllerProtocol? = nil, child: [UIViewController]? = nil, coreDataStack: CoreDataStackProtocol) {
        self.tabBarController = tabBarController
        self.child = child
        self.coreDataStack = coreDataStack
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    func requestForUpdateUIFromStorage() {
        guard let vc = (child?[Tabs.home.rawValue] as? UINavigationController)?.viewControllers.first as? HomeViewProtocol else { return }
        vc.requestForUpdateUIFromStorage()
    }
    
    func appEnterBackground() {
        guard let vc = child?[Tabs.timer.rawValue] as? TimerViewProtocol else { return }
        vc.enterBackground()
        coreDataStack.saveContext()
    }
    
    func appEnterForeground() {
        guard let vc = child?[Tabs.timer.rawValue] as? TimerViewProtocol else { return }
        vc.enterForeground()
    }
    
    func openAndStartTimer(with session: SessionSetup) {
        switchTabTo(.timer)
        guard let vc = child?[Tabs.timer.rawValue] as? TimerViewProtocol else { return }
        vc.start(with: session)
    }
    
    func switchTabTo(_ tab: Tabs) {
        tabBarController?.switchTabTo(tab.rawValue)
    }
}
