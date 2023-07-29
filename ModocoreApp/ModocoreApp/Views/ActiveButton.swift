//
//  ActiveButton.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 26.07.2023.
//

import UIKit

final class ActiveButton: UIButton {
    // MARK: - Public properties
    public var labelText: String = "" {
        didSet {
            nameLabel.text = labelText
        }
    }
    
    public var BgColor: UIColor = .circleAndTextBlue {
        didSet {
            backgroundColor = BgColor
        }
    }
    
    // MARK: - Views
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAndLayoutView()
    }
}

// MARK: - Private extension
private extension ActiveButton {
    func setupAndLayoutView() {
        layer.cornerRadius = 23
        backgroundColor = .circleAndTextBlue
        
        addViews(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
