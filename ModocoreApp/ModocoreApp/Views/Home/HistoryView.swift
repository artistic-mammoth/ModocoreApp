//
//  HistoryView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.07.2023.
//

import UIKit

final class HistoryView: UIView {
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 17)
        label.text = "Focus history"
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
        setupStackView()
        
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
    
    func setupStackView() {
        stack.arrangedSubviews.forEach { (view) in
            stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for _ in 0..<22 {
            // TODO: - Change it after additing history
            stack.addArrangedSubview(getBarShape(CGFloat.random(in: 0...1)))
        }
    }
    
    func getBarShape(_ progress: CGFloat) -> UIView {
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 50))
        
        let shape = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: bar.bounds.maxY))
        path.addLine(to: CGPoint(x: 0, y: bar.bounds.maxY * (1 - progress)))
        
        shape.path = path.cgPath
        shape.lineWidth = 7.0
        shape.strokeColor = progress < 0.5 ? UIColor.grayBar.cgColor : UIColor.fire.cgColor
        shape.lineCap = .round
        bar.layer.addSublayer(shape)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double.random(in: 0.2...0.7)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        shape.add(animation, forKey: nil)

        return bar
    }
}
