//
//  IntervalTypeLabel.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 26.07.2023.
//

import UIKit

final class IntervalTypeLabel: UILabel {
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAndLayoutView()
    }

    // MARK: - Public methods
    func switchType(to type: IntervalType) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
            switch type {
            case .focus: self?.text = "FOCUS"
            case .rest: self?.text = "REST"
            }
        }
    }
    
    func resetText() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
            self?.text = ""
        }
    }
}

// MARK: - Private extension
private extension IntervalTypeLabel {
    func setupAndLayoutView() {
        textColor = .white
        textAlignment = .center
        font = UIFont.lightInter(size: 28)
        sizeToFit()
    }
}
