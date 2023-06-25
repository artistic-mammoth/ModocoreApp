//
//  ClockView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

final class ClockView: UIView {
    // MARK: - Private properties
    private var circleShapes: [CircleShape] = []

    // MARK: - Views
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.blackInter(size: 34)
        label.textAlignment = .center
        label.textColor = .white
        return label
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
        for item in circleShapes {
            item.startAnimation()
        }
        updateTime(with: timeInSec)
    }
    
    func updateTime(with timeInSec: Int) {
        var timeArr: [Int] = []
        timeArr.append(timeInSec / 60)
        timeArr.append(timeInSec % 60)
        let h = timeArr[0]
        let m = timeArr[1] < 10 ? "0\(timeArr[1])" : "\(timeArr[1])"
        timeLabel.text = "\(h):\(m)"
    }
    
    func stopTimer() {
        for item in circleShapes {
            item.stopAnimation()
        }
        timeLabel.text = ""
    }
}

// MARK: - Private extension
private extension ClockView {
    func configureAppearance() {
        circleShapes = getCircleViews()
        circleShapes.forEach(layer.addSublayer(_:))
    }
    
    func layoutView() {
        addViews([timeLabel])
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            timeLabel.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func getCircleParameters() -> [CircleParameters] {
        let cParam4 = CircleParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 20, diameter: 300, frequency: 5, speed: 1 / 1000.0, opacity: 1, color: UIColor.white)
        let cParam3 = CircleParameters(powAmplitude: 3, powDynamics: 4, waveAmplitude: 5, diameter: 300, frequency: 4, speed: 1 / 1000.0, opacity: 0.75, color: UIColor.white)
        let cParam2 = CircleParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 11, diameter: 300, frequency: 6, speed: 1 / 500.0, opacity: 0.50, color: UIColor(hexString: "#4D5ADA"))
        let cParam1 = CircleParameters(powAmplitude: 3, powDynamics: 4, waveAmplitude: 50, diameter: 300, frequency: 8, speed: 1 / 500.0, opacity: 0.25, color: UIColor(hexString: "#4D5ADA"))
        
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
