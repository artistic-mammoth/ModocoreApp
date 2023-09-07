//
//  TimerViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

final class TimerViewController: UIViewController {
    // MARK: - Private properties
    private var counterService: CounterService?
    private var isPaused = false
    private var isStarted = false
    
    // MARK: - Views
    private lazy var clockView = ClockView()
    private lazy var intervalTypeLabel = IntervalTypeLabel()
    private lazy var statusIndicatorView = StatusIndicatorView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLayoutView()
        setupSwipeNavigation()
    }
    
    // MARK: - Override
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Public methods
    func startTimer(with session: SessionSetup) {
        guard !isStarted else { return }
        
        isStarted = true
        
        counterService = CounterService(session)
        counterService?.delegate = self
        counterService?.runCounter()
    }
    
    func enterBackground() {
        guard counterService != nil && !isPaused else { return }
        counterService?.enterBackground()
    }
    
    func enterForeground() {
        guard counterService != nil && !isPaused else { return }
        counterService?.enterForeground()
    }
}

// MARK: - Private extension
private extension TimerViewController {
    func setupAndLayoutView() {
        view.addViews(intervalTypeLabel, clockView, statusIndicatorView)
        view.backgroundColor = .blackBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clockViewBtnHandler))
        clockView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            intervalTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            intervalTypeLabel.widthAnchor.constraint(equalToConstant: 100),
            intervalTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            intervalTypeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            clockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            clockView.heightAnchor.constraint(equalToConstant: 273),
            clockView.widthAnchor.constraint(equalToConstant: 273),
            
            statusIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -111),
            statusIndicatorView.heightAnchor.constraint(equalToConstant: 25),
            statusIndicatorView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100)
        ])
    }
    
    @objc func clockViewBtnHandler() {
        guard isStarted else { return }

        if isPaused {
            counterService?.resumeTimer()
            clockView.resumeClock()
            isPaused = false
        }
        else {
            counterService?.pauseTimer()
            clockView.pauseClock()
            isPaused = true
        }
    }
}

// MARK: - CounterDelegate extension
extension TimerViewController: ClockDelegate {
    func runClock(with setup: SessionSetup) {
        intervalTypeLabel.switchType(to: setup[0].type)
        clockView.runClock(with: setup[0].seconds)
        statusIndicatorView.configure(with: setup)
    }
    
    func updateClockTime(_ seconds: Int) {
        clockView.currentClockSeconds = seconds
    }
    
    func updateClock(with param: IntervalParameters, skipFor: Int) {
        intervalTypeLabel.switchType(to: param.type)
        clockView.currentClockSeconds = param.seconds
        statusIndicatorView.fillNextCircle(for: skipFor)
    }
    
    func stopClock() {
        intervalTypeLabel.resetText()
        clockView.stopClock()
        statusIndicatorView.fillNextCircle(for: Int.max)
        counterService = nil
        isStarted = false
    }
}
