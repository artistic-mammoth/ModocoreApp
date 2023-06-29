//
//  CircleShape.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 12.06.2023.
//

import UIKit

final class CircleShape: CAShapeLayer {
    // MARK: - Private properties
    private var param: CircleParameters = CircleParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 20, diameter: 300, frequency: 3, speed: 1 / 1000.0, opacity: 1, color: .white)

    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    init(with parameters: CircleParameters) {
        super.init()
        self.param = parameters
        drawCircle()
    }
    
    // MARK: - Public methods
    func startAnimation() {
        let animation = getWaveAnimation(with: param)
        add(animation, forKey: nil)
    }
    
    func stopAnimation() {
        let animation = getStopAnimation(with: param)
        add(animation, forKey: nil)
    }
}

// MARK: - Private extension
private extension CircleShape {
    func getNewPath(_ factor: Double, param: CircleParameters) -> UIBezierPath {
        let points = 180
        let shift: Double = 2 * Double.pi / 3
        let path = UIBezierPath()
        let radius = Double(param.diameter / 2)
        let waveAmplitude: Double = Double(param.diameter) / 20
        let circleRadius: Double = radius - 2 * waveAmplitude
        let center = CGPoint(x: radius - waveAmplitude, y: radius - waveAmplitude)
        
        for i in 0..<points {
            let a: Double = Double(i) * 2 * Double.pi / Double(points)
            let s: Double = factor * param.speed
            let p: Double = pow(((Double(param.powAmplitude) + cos(a - s)) / Double(param.powDynamics)), 3)
            let r: Double = Double(circleRadius + waveAmplitude * cos(a * Double(param.frequency) - shift + s) * p)
            let x: Double = Double(center.x) + (r * sin(a))
            let y: Double =  Double(center.y) + (r * -cos(a))
            
            if i == 0 { path.move(to: CGPoint(x: x, y: y)) }
            else { path.addLine(to: CGPoint(x: x, y: y)) }
        }
        
        path.close()
        return path
    }
    
    func drawCircle() {
        let pathN = getNewPath(1, param: param)
        path = pathN.cgPath
        strokeColor = param.color.cgColor
        lineWidth = 1
        strokeEnd = 1
        opacity = param.opacity
        fillColor = UIColor.clear.cgColor
        lineCap = .round
    }
    
    func getWaveAnimation(with param: CircleParameters) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "path")

        var animseq: [CGPath] = []
        let shards = 180
        
        for i in 0...shards {
            animseq.append(getNewPath(Double(i) / Double(shards) * Double.pi * 2000, param: param).cgPath)
        }
        
        animation.calculationMode = CAAnimationCalculationMode.cubic
        animation.duration = 3
        animation.values = animseq.reversed()
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.repeatCount = .greatestFiniteMagnitude
        
        return animation
    }
    
    func getStopAnimation(with param: CircleParameters) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "path")
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.toValue = getNewPath(0, param: param)
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
}
