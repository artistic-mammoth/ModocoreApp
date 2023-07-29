//
//  TemplateViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 03.05.2023.
//

import UIKit

final class TemplateViewController: UIViewController {
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = UIFont.blackInter(size: 28)
        label.text = "Coming soon..."
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layoutView()
        setupSwipeNavigation()
        
    }
    
    private func layoutView() {
        view.addViews([label])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 200),
            label.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setupSwipeNavigation() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            TabBarController.shared.switchTabTo(self.tabBarController!.selectedIndex + 1)
        }
        if sender.direction == .right {
            TabBarController.shared.switchTabTo(self.tabBarController!.selectedIndex - 1)
        }
    }
}
