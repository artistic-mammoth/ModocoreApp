//
//  TabBarItemView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 03.05.2023.
//

import UIKit

class TabBarItemView: UIButton {
    // MARK: - Public properties
    var isSelectedItem: Bool = false {
        didSet {
            substrate.isHidden = isSelectedItem ? false : true
        }
    }
    
    // MARK: - Views
    private let iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.tintColor = UIColor(hexString: "#F3F3F3")
        return view
    }()
    
    private let substrate: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.3
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: - Init
    convenience init(icon: UIImage?) {
        self.init()
        iconView.image = icon?.withRenderingMode(.alwaysTemplate)
        setupView()
    }
}

// MARK: - Private extension
private extension TabBarItemView {
    func setupView() {
        addViews(substrate, iconView)
        substrate.layer.cornerRadius = 9
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            substrate.trailingAnchor.constraint(equalTo: trailingAnchor),
            substrate.leadingAnchor.constraint(equalTo: leadingAnchor),
            substrate.topAnchor.constraint(equalTo: topAnchor),
            substrate.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
