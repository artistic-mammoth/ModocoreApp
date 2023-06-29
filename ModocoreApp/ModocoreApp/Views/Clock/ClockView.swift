//
//  ClockView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

final class ClockView: UIView {
    // MARK: - Private properties
    private lazy var circleShapes: [CircleShape] = []

    // MARK: - Views
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.blackInter(size: 34)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var resumeIcon: UIImageView = {
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
        configureAppearance()
        layoutView()
    }
    
    // MARK: - Public methods
    func startTimer(with timeInSec: Int) {
        resumeIcon.isHidden = true
        timeLabel.isHidden = false

        for item in circleShapes {
            item.startAnimation()
        }
        updateTime(with: timeInSec)
    }
    
    func updateTime(with timeInSec: Int) {
        timeLabel.text = .secondsToString(timeInSec)
    }
    
    func stopTimer() {
        timeLabel.isHidden = true
        resumeIcon.isHidden = false
        
        for item in circleShapes {
            item.stopAnimation()
        }
    }
    
    func pauseTimer() {
        timeLabel.isHidden = true
        resumeIcon.isHidden = false
    }
    
    func resumeTimer() {
        resumeIcon.isHidden = true
        timeLabel.isHidden = false
    }
}

// MARK: - Private extension
private extension ClockView {
    func configureAppearance() {
        circleShapes = getCircleViews()
        circleShapes.forEach(layer.addSublayer(_:))
        
        timeLabel.isHidden = true
    }
    
    func layoutView() {
        addViews([timeLabel, resumeIcon])
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            timeLabel.widthAnchor.constraint(equalToConstant: 120),
            
            resumeIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            resumeIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            resumeIcon.heightAnchor.constraint(equalToConstant: 50),
            resumeIcon.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func getCircleParameters() -> [CircleParameters] {
        let cParam4 = CircleParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 20, diameter: 300, frequency: 5, speed: 1 / 1000.0, opacity: 1, color: UIColor.white)
        let cParam3 = CircleParameters(powAmplitude: 3, powDynamics: 4, waveAmplitude: 5, diameter: 300, frequency: 4, speed: 1 / 1000.0, opacity: 0.75, color: UIColor.white)
        let cParam2 = CircleParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 11, diameter: 300, frequency: 6, speed: 1 / 500.0, opacity: 0.50, color: .circleBlue)
        let cParam1 = CircleParameters(powAmplitude: 3, powDynamics: 4, waveAmplitude: 50, diameter: 300, frequency: 8, speed: 1 / 500.0, opacity: 0.25, color: .circleBlue)
        
        return [cParam1, cParam2, cParam3, cParam4]
    }
    
    private func getCircleViews() -> [CircleShape] {
        let params = getCircleParameters()
        var circleShapes: [CircleShape] = []
        for param in params {
            let circle = CircleShape(with: param)
            circleShapes.append(circle)
        }
        return circleShapes
    }
}
