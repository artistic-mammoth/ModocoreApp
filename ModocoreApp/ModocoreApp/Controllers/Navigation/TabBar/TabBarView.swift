//
//  TabBarView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 03.05.2023.
//

import UIKit

class TabBarView: UITabBar {
    
    // MARK: - Properties
    var itemsWrapped = [TabBarItemView]()
    
    // MARK: Views
    let stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()
    
    // MARK: - Init
    convenience init(items: [TabBarItemView]) {
        self.init()
        itemsWrapped = items
        setupView()
    }
    
    // MARK: - UI
    private func setupView() {
        addSubview(stackView)
        
        translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        isTranslucent = false
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(hexString: "#16161B")
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
        ])
        
        for i in 0 ..< itemsWrapped.count {
            let item = itemsWrapped[i]
            stackView.addArrangedSubview(item)
            
            NSLayoutConstraint.activate([
                item.widthAnchor.constraint(equalTo: stackView.heightAnchor)
            ])
        }
    }
    
    
}
