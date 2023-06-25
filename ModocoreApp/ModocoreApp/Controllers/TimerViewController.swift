//
//  TimerViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

final class TimerViewController: UIViewController, CounterDelegate {
    let time = 3
    
    let label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.lightInter(size: 28)
        label.sizeToFit()
        return label
    }()
    
    var clockView: ClockView?
    var counterController: CounterController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        layoutViews()
        counterController = CounterController()
        counterController?.delegate = self
        counterController?.startCounter(with: time)

    }
    
    func updateTime(with timeInSec: Int) {
        clockView?.updateTime(with: timeInSec)
    }
    
    func startTimer(with timeInSec: Int) {
        clockView = ClockView()
        if let clockView = clockView {
            view.addViews(clockView)
        }
        
        clockView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clockView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        clockView?.heightAnchor.constraint(equalToConstant: 273).isActive = true
        clockView?.widthAnchor.constraint(equalToConstant: 273).isActive = true
        clockView?.startTimer(with: timeInSec)
        label.text = "FOCUS"
        view.layoutIfNeeded()
    }
    
    func stopTimer() {
        clockView?.stopTimer()
        label.text = ""
        counterController = nil
        clockView?.removeFromSuperview()
        clockView = nil
    }

}

private extension TimerViewController {
    func configureAppearance() {
        view.addViews([label])
        view.backgroundColor = UIColor(hexString: "16161B")
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        ])
    }
}
