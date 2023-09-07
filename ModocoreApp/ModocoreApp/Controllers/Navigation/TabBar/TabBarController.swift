//
//  TabBarController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 02.05.2023.
//

import UIKit


final class TabBarController: UITabBarController {
    // MARK: - Private properties
    private var tabBarView: TabBarView!
    
    private(set) lazy var homeController = UINavigationController(rootViewController: HomeAssembly.build())
    private(set) lazy var timerController = TimerViewController()
    private(set) lazy var templateController = TemplateViewController()
    
    static let shared: TabBarController = TabBarController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        
        let home = TabBarItemView(icon: UIImage(systemName: "house.circle"))
        let timerItem = TabBarItemView(icon: UIImage(systemName: "timer.circle.fill"))
        let template = TabBarItemView(icon: UIImage(systemName: "gear.circle"))
        
        setTabBar(items: [home, timerItem, template])
        viewControllers = [homeController, timerController, templateController]
        
        // TODO: - delete after testing
//        selectedIndex = 1
//        tabBarView.setCustomAppearance(true)
//        tabBarView.itemsWrapped[0].isSelectedItem = false
//        tabBarView.itemsWrapped[1].isSelectedItem = true
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
