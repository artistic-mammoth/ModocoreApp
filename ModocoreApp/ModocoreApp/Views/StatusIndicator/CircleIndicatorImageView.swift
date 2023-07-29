//
//  CircleIndicatorImageView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 25.07.2023.
//

import UIKit

final class CircleIndicatorImageView: UIImageView {
    // MARK: - Public properties
    var isFilled: Bool = false {
        didSet {
            setImage()
        }
    }
    
    var intervalType: IntervalType = .focus {
        didSet {
            setIntervalType()
        }
    }
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(intervalType: IntervalType, isFilled: Bool = false) {
        self.init(frame: .zero)
        self.intervalType = intervalType
        self.isFilled = isFilled
        setupView()
    }
}

// MARK: - Private extension
private extension CircleIndicatorImageView {
    func setupView() {
        contentMode = .scaleAspectFit
        setIntervalType()
        setImage()
    }
    
    func setImage() {
        image = isFilled ? .circleFillIndicator : .circleIndicator
    }
    
    func setIntervalType() {
        tintColor = intervalType == .focus ? .indicatorFocus : .indicatorRest
    }
}
