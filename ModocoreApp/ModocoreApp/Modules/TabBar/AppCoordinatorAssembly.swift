//
//  AppCoordinatorAssembly.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.09.2023.
//

import UIKit

enum Tabs: Int {
    case home
    case timer
    case template
}

final class AppCoordinatorAssembly {
    static func build() -> AppCoordinatorProtocol {
        let tabBarController = TabBarController()
        let appCoordinator = AppCoordinator(tabBarController: tabBarController)
        
        let homeController = UINavigationController(rootViewController: HomeAssembly.build(appCoordinator: appCoordinator))
        let timerController = TimerAssembly.build()
        let templateController = TemplateViewController()
        
        let homeItem = TabBarItemView(icon: UIImage(systemName: "house.circle"))
        let timerItem = TabBarItemView(icon: UIImage(systemName: "timer.circle.fill"))
        let templateItem = TabBarItemView(icon: UIImage(systemName: "gear.circle"))
        
        let tabs: [TabsItems] = [(homeController, homeItem),
                    (timerController, timerItem),
                    (templateController, templateItem)]
        
        tabBarController.setupWith(tabs: tabs)
        appCoordinator.child = tabs.map( { $0.0 })
        
        return appCoordinator
    }
}
