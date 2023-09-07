//
//  WeekStreakView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.07.2023.
//

import UIKit

final class WeekStreakView: UIView {
    // MARK: - Public properties
    var currentStreak: Int = 0 {
        didSet {
            updateStackView()
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldInter(size: 17)
        label.text = Catalog.Names.weekStreakTitle
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
        addViews(titleLabel, stack)
        updateStackView()
        
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
    
    func updateStackView() {
        stack.arrangedSubviews.forEach { (view) in
            stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    
        for _ in 0..<7 {
            stack.addArrangedSubview(getFireIcon())
        }
        
        for (index, view) in stack.arrangedSubviews.enumerated() {
            guard index < currentStreak else { break }
            view.alpha = 0.7
            UIView.animate(withDuration: 0.5, delay: 0.06 * Double(index), options: .curveEaseOut, animations: {
                view.alpha = 1
            }) { _ in
                view.tintColor = .fire
            }
        }
    }
    
    func getFireIcon(_ isFire: Bool = false) -> UIImageView {
        let icon = UIImageView()
        icon.image = .flameIcon
        icon.tintColor = isFire ? .fire : .grayBackground
        icon.contentMode = .scaleAspectFit
        return icon
    }
}
