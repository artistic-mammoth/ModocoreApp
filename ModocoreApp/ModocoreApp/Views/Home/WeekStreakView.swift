//
//  WeekStreakView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.07.2023.
//

import UIKit

final class WeekStreakView: UIView {
    // MARK: - Public properties
    var currentStreak: Int = .random(in: 0...7) {
        didSet {
            setupStackView()
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 17)
        label.text = "Week streak"
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var stack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAndLayoutView()
    }
}

// MARK: - Private extension
private extension WeekStreakView {
    func setupAndLayoutView() {
        addViews([titleLabel, stack])
        setupStackView()
        
        backgroundColor = .blackBackground
        layer.cornerRadius = 23
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func setupStackView() {
        stack.arrangedSubviews.forEach { (view) in
            stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for _ in 0..<currentStreak {
            stack.addArrangedSubview(getFireIcon(true))
        }
        
        for _ in 0..<(7 - currentStreak) {
            stack.addArrangedSubview(getFireIcon(false))
        }
        setNeedsLayout()
    }
    
    func getFireIcon(_ isFire: Bool) -> UIImageView {
        let icon = UIImageView()
        icon.image = .flameIcon
        icon.tintColor = isFire ? .fire : .grayBackground
        icon.contentMode = .scaleAspectFit
        return icon
    }
}
