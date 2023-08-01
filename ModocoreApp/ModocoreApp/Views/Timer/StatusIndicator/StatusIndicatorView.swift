//
//  StatusIndicatorView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 25.07.2023.
//

import UIKit

final class StatusIndicatorView: UIView {
    // MARK: - Private properties
    private let stackCellWidth: CGFloat = 25
    
    // MARK: - Views
    private lazy var stackView: UIStackView = {
       var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAndLayoutView()
    }

    // MARK: - Public methods
    func configure(with setup: SessionSetup) {
        var views = stackView.arrangedSubviews as! [CircleIndicatorImageView]
        
        while views.count > setup.session.count {
            views.removeLast().removeFromSuperview()
        }
        
        for i in 0..<setup.session.count {
            if i < views.count {
                views[i].intervalType = setup.session[i].type
                views[i].isFilled = false
            }
            else {
                stackView.addArrangedSubview(CircleIndicatorImageView(intervalType: setup.session[i].type))
            }
        }
        
        stackView.constraints.first(where: { $0.firstAttribute == .width })?.constant = stackCellWidth * CGFloat(setup.session.count)
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    func fillNextCircle(for count: Int = 1) {
        var count = count
        let views = stackView.arrangedSubviews as! [CircleIndicatorImageView]
        for i in 0..<views.count {
            if !views[i].isFilled {
                count -= 1
                views[i].isFilled = true
                if count <= 0 {
                    break
                }
            }
        }
    }
}

// MARK: - Private extension
private extension StatusIndicatorView {
    private func setupAndLayoutView() {
        addViews(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: stackCellWidth),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
