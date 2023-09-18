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
        addViews(nameLabel)

        layer.cornerRadius = 23
        backgroundColor = .circleAndTextBlue
        addAnimationsForButtonEvents()
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func addAnimationsForButtonEvents() {
        let animationDownAction: UIAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
                self.alpha = 0.9
            }
        }
        
        let animationUpAction: UIAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.transform = .identity
                self.alpha = 1
            }
        }
        
        addAction(animationDownAction, for: [.touchDown, .touchDragEnter])
        addAction(animationUpAction, for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
}
