//
//  TabBarController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 02.05.2023.
//

import UIKit


class TabBarController: UITabBarController {
    // MARK: - Properties
    var tabBarView: TabBarView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupView()
    }
    
    // MARK: - UI
    private func setTabBar(items: [TabBarItemView]) {
        guard items.count > 0 else { return }
        
        view.addSubview(tabBarView)

        tabBarView = TabBarView(items: items)
        tabBarView.itemsWrapped.first?.isSelectedItem = true
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarView.layer.cornerRadius = 17
        tabBarView.clipsToBounds = true
        
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
        selectedIndex = newIndex
    }

    func setupView() {
        
        let home = TabBarItemView(icon: UIImage(systemName: "house.circle"))
        let timer = TabBarItemView(icon: UIImage(systemName: "timer.circle.fill"))
        let settings = TabBarItemView(icon: UIImage(systemName: "gear.circle"))
        
        let red = RedViewController()
        let blue = BlueViewController()
        let green = GreenViewController()
        
        setTabBar(items: [home, timer, settings])
        viewControllers = [red, blue, green]
        
    }
    
}
