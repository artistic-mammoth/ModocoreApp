//
//  TabBarView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 03.05.2023.
//

import UIKit

class TabBarView: UITabBar {
    // MARK: - Public properties
    var itemsWrapped = [TabBarItemView]()
    
    // MARK: - Private properties
    private let appearance = UITabBarAppearance()
    
    // MARK: - Views
    private let stackView: UIStackView = {
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
    
    // MARK: - Public methods
    func setCustomAppearance(_ isDark: Bool = false) {
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = isDark ? UIColor(hexString: "#363642") : UIColor(hexString: "#16161B")
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}

// MARK: - Private extension
private extension TabBarView {
    func setupView() {
        addViews(stackView)
        isTranslucent = false
        setCustomAppearance()

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
        ])
        
        for item in itemsWrapped {
            item.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(item)
            item.widthAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
        }
    }
}
