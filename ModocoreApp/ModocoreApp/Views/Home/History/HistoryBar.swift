//
//  HistoryBar.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 31.07.2023.
//

import UIKit

final class HistoryBar: UIView {
    // MARK: - Private properties
    private let progress: Double
    private let shape = CAShapeLayer()
    private let path = UIBezierPath()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init(_ progress: Double) {
        self.progress = progress
        super.init(frame: CGRect(x: 0, y: 0, width: 7, height: 50))
        setupAndLayoutView()
    }
}

// MARK: - Private extension
private extension HistoryBar {
    private func setupAndLayoutView() {
        path.move(to: CGPoint(x: 0, y: bounds.maxY))
        path.addLine(to: CGPoint(x: 0, y: bounds.maxY * (1 - progress)))
        
        shape.path = path.cgPath
        shape.lineWidth = 7.0
        shape.strokeColor = progress < 0.5 ? UIColor.grayBar.cgColor : UIColor.fire.cgColor
        shape.lineCap = .round
        layer.addSublayer(shape)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double.random(in: 0.2...0.7)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        shape.add(animation, forKey: nil)
    }
}
