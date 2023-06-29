//
//  TimerViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

final class TimerViewController: UIViewController {
    // TODO: remove after testing
    private let parameters = [TimerParameters(status: .focus, timeInSec: 2), TimerParameters(status: .rest, timeInSec: 2)]
//    private let parameters: [TimerParameters] = []

    
    // MARK: - Private properties
    private var counterService: CounterService?
    private var isPaused = false
    private var isStarted = false
    
    // MARK: - Views
    private lazy var clockView = ClockView()
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.lightInter(size: 28)
        label.sizeToFit()
        return label
    }()
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        layoutViews()
    }

}

// MARK: - Private extension
private extension TimerViewController {
    func configureAppearance() {
        view.addViews([label, clockView])
        view.backgroundColor = .blackBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pauseTimer))
        clockView.addGestureRecognizer(tapGesture)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            clockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            clockView.heightAnchor.constraint(equalToConstant: 273),
            clockView.widthAnchor.constraint(equalToConstant: 273),
        ])
    }
    
    @objc func pauseTimer() {
        if !isStarted {
            guard parameters.count > 0 else { return }
            isStarted = true
            counterService = CounterService(parameters)
            counterService?.delegate = self
            counterService?.startCounter()
            return
        }
        
        if isPaused {
            counterService?.resumeTimer()
            clockView.resumeTimer()
            isPaused = false
        }
        else {
            counterService?.pauseTimer()
            clockView.pauseTimer()
            isPaused = true
        }
    }
}

// MARK: - CounterDelegate extension
extension TimerViewController: CounterDelegate {
    func startTimer(with param: TimerParameters) {
        clockView.startTimer(with: param.timeInSec)
        
        UIView.transition(with: label, duration: 1.5, options: .transitionCrossDissolve) { [weak self] in
            switch param.status {
            case .focus: self?.label.text = "FOCUS"
            case .rest: self?.label.text = "REST"
            }
        }
    }
    
    func updateTime(with timeInSec: Int) {
        clockView.updateTime(with: timeInSec)
    }
    
    func switchState(with param: TimerParameters) {
        clockView.updateTime(with: param.timeInSec)
        
        UIView.transition(with: label, duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
            switch param.status {
            case .focus: self?.label.text = "FOCUS"
            case .rest: self?.label.text = "REST"
            }
        }
    }
    
    func stopTimer() {
        clockView.stopTimer()
        
        UIView.transition(with: label, duration: 1.5, options: .transitionCrossDissolve) { [weak self] in
            self?.label.text = ""
        }
        
        counterService = nil
        isStarted = false
    }

}
