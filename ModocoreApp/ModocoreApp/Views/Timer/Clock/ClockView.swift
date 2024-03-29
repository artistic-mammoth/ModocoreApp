//
//  ClockView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

final class ClockView: UIView {
    // MARK: - Public properties
    var currentClockSeconds: Int = 0 {
        didSet {
            clockLabel.text = .secondsToString(currentClockSeconds)
        }
    }
    
    // MARK: - Private properties
    private lazy var circleShapes: [CircleShape] = []

    // MARK: - Views
    private lazy var clockLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.blackInter(size: 34)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var playIcon: UIImageView = {
       let view = UIImageView()
        view.image = .playIcon
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAndLayoutView()
    }
    
    // MARK: - Public methods
    func runClock(with seconds: Int) {
        playIcon.isHidden = true
        clockLabel.isHidden = false

        for item in circleShapes {
            item.startAnimation()
        }
        
        currentClockSeconds = seconds
    }

    func stopClock() {
        clockLabel.isHidden = true
        playIcon.isHidden = false
        
        for item in circleShapes {
            item.stopAnimation()
        }
    }
    
    func pauseClock() {
        clockLabel.isHidden = true
        playIcon.isHidden = false
    }
    
    func resumeClock() {
        playIcon.isHidden = true
        clockLabel.isHidden = false
    }
}

// MARK: - Private extension
private extension ClockView {
    func setupAndLayoutView() {
        addViews(clockLabel, playIcon)
        
        circleShapes = getCircleShapes()
        circleShapes.forEach(layer.addSublayer(_:))
        
        clockLabel.isHidden = true
        playIcon.isHidden = true
        
        NSLayoutConstraint.activate([
            clockLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            clockLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            clockLabel.heightAnchor.constraint(equalToConstant: 50),
            clockLabel.widthAnchor.constraint(equalToConstant: 120),
            
            playIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            playIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            playIcon.heightAnchor.constraint(equalToConstant: 50),
            playIcon.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func getCircleShapes() -> [CircleShape] {
        let params = Catalog.circleShapeParameters
        var circleShapes: [CircleShape] = []
        for param in params {
            let circle = CircleShape(with: param)
            circleShapes.append(circle)
        }
        return circleShapes
    }
}
