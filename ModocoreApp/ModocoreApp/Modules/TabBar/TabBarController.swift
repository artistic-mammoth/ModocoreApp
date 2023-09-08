//
//  TabBarController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 02.05.2023.
//

import UIKit

protocol TabBarControllerProtocol {
    func switchTabTo(_ id: Int)
    func setupWith(tabs: [TabsItems])
}

typealias TabsItems = (UIViewController, TabBarItemView)

final class TabBarController: UITabBarController {
    // MARK: - Private properties
    private var tabBarView: TabBarView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
// MARK: - TabBarControllerProtocol
extension TabBarController: TabBarControllerProtocol {
    func setupWith(tabs: [TabsItems]) {
        let views = tabs.map({ $0.0 })
        viewControllers = views
        
        let items = tabs.map({ $0.1 })
        setTabBar(items: items)
    }
    
    func switchTabTo(_ id: Int) {
        guard let vcCount = viewControllers?.count else { return }
        guard id < vcCount && id >= 0 else { return }
        tabBarView.setCustomAppearance(id == 1)
        tabBarView.itemsWrapped[selectedIndex].isSelectedItem = false
        tabBarView.itemsWrapped[id].isSelectedItem = true
        selectedIndex = id
    }
}

// MARK: - Private extension
private extension TabBarController {
    func setupView() {
        tabBar.isHidden = true
    }
    
    func setTabBar(items: [TabBarItemView]) {
        guard items.count > 0 else { return }
        
        tabBarView = TabBarView(items: items)
        tabBarView.itemsWrapped.first?.isSelectedItem = true
        tabBarView.layer.cornerRadius = 17
        tabBarView.clipsToBounds = true
        
        view.addViews(tabBarView)

        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            tabBarView.heightAnchor.constraint(equalToConstant: 56)
        ])

        for i in 0 ..< items.count {
            items[i].tag = i
            items[i].addTarget(self, action: #selector(switchTab), for: .touchUpInside)
        }
    }
    
    @objc func switchTab(button: UIButton) {
        let newIndex = button.tag
        tabBarView.itemsWrapped[selectedIndex].isSelectedItem = false
        tabBarView.itemsWrapped[newIndex].isSelectedItem = true
        tabBarView.setCustomAppearance(newIndex == 1)
        selectedIndex = newIndex
    }
}
