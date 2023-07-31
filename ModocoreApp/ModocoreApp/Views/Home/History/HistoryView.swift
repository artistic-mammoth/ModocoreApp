//
//  HistoryView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.07.2023.
//

import UIKit

final class HistoryView: UIView {
    // MARK: - Public properties
    var historySeconds: [Int] = [] {
        didSet {
            updateStackView()
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 17)
        label.text = Catalog.Names.historyTitle
        label.textAlignment = .left
        label.textColor = .black
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
private extension HistoryView {
    func setupAndLayoutView() {
        addViews([titleLabel, stack])
        updateStackView()
        
        backgroundColor = .clear
        
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
        stack.arrangedSubviews.forEach { view in
            stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        let countHistory = historySeconds.count <= 22 ? historySeconds.count : 22
        
        for _ in 0..<22 - countHistory {
            stack.addArrangedSubview(HistoryBar(0))
        }
        
        guard !historySeconds.isEmpty else { return }
        
        let maxFocus = historySeconds.max() ?? 1
        
        for i in 0..<countHistory {
            let progress: Double = Double(historySeconds[i]) / Double(maxFocus)
            stack.addArrangedSubview(HistoryBar(progress))
        }
    }
}
