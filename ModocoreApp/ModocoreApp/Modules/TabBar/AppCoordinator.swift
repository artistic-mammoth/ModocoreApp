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
    func switchTabTo(_ tab: Tabs)
    func openAndStartTimer(with session: SessionSetup)
    func appEnterBackground()
    func appEnterForeground()
}

class AppCoordinator {
    var tabBarController: TabBarControllerProtocol?
    var child: [UIViewController]?
    
    init(tabBarController: TabBarControllerProtocol? = nil, child: [UIViewController]? = nil) {
        self.tabBarController = tabBarController
        self.child = child
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    func appEnterBackground() {
        guard let vc = child?[Tabs.timer.rawValue] as? TimerViewProtocol else { return }
        vc.enterBackground()
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
