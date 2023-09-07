//
//  UIViewController+Swipeable.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 06.09.2023.
//

import UIKit

extension UIViewController {
    func setupSwipeNavigation() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            TabBarController.shared.switchTabTo(self.tabBarController!.selectedIndex + 1)
            
        }
        if sender.direction == .right {
            TabBarController.shared.switchTabTo(self.tabBarController!.selectedIndex - 1)
        }
    }
}
