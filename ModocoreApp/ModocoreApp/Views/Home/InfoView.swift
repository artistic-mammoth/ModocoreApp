//
//  InfoView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.07.2023.
//

import UIKit

final class InfoView: UIView {
    // MARK: - Public properties
    public var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    public var count: Int = 0 {
        didSet {
            countLabel.text = String(count)
        }
    }
    
    public var totalSeconds: Int = 0 {
        didSet {
            setTimeText()
        }
    }
    
    public var isBlackTheme: Bool = true {
        didSet {
            configureBackground()
        }
    }
    
    // MARK: - Views
    private lazy var stackTime: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var stack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 17)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var totalTimeLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 17)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var countLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 34)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timePrefixLabel: UILabel = {
       let label = UILabel()
        label.text = " \(Catalog.Names.timePrefixMinutesName)"
        label.font = .mediumInter(size: 13)
        label.textAlignment = .left
        return label
    }()

    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAndLayoutView()
    }

    // MARK: - Override
    override var intrinsicContentSize: CGSize {
        CGSize(width: 150, height: 120)
    }
}

// MARK: - Private extension
private extension InfoView {
    func setupAndLayoutView() {
        configureBackground()
        setTimeText()
        layer.cornerRadius = 23
        
        stackTime.addArrangedSubview(totalTimeLabel)
        stackTime.addArrangedSubview(timePrefixLabel)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(countLabel)
        stack.addArrangedSubview(stackTime)
        
        addViews(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
        ])
    }
    
    func configureBackground() {
        backgroundColor = isBlackTheme ? .blackBackground : .grayBackground
        titleLabel.textColor = isBlackTheme ? .white : .black
        countLabel.textColor = isBlackTheme ? .white : .black
        totalTimeLabel.textColor = isBlackTheme ? .white : .black
        timePrefixLabel.textColor = isBlackTheme ? .white : .black
    }
    
    func setTimeText() {
        if totalSeconds < 60 {
            totalTimeLabel.text = "\(totalSeconds) "
            timePrefixLabel.text = " \(Catalog.Names.timePrefixSecondsName)"
        } else if totalSeconds / 60 <= 1000 {
            totalTimeLabel.text = "\(totalSeconds / 60) "
            timePrefixLabel.text = " \(Catalog.Names.timePrefixMinutesName)"
        } else {
            totalTimeLabel.text = "\(totalSeconds / 60 / 60) "
            timePrefixLabel.text = " \(Catalog.Names.timePrefixHoursName)"
        }
    }
}
