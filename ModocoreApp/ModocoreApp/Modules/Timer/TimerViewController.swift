//
//  TimerViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

protocol TimerViewProtocol: AnyObject {
    func start(with session: SessionSetup)
    func runClock(startSeconds: Int, types: [IntervalType])
    func updateClockTime(_ seconds: Int)
    func updateClock(with param: IntervalParameters, skipFor: Int)
    func stopClock()
    func pauseClock()
    func resumeClock()
    func enterBackground()
    func enterForeground()
}

final class TimerViewController: UIViewController {
    // MARK: - Public properties
    var presenter: TimerPresenterProtocol?
    
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
}

// MARK: - TimerViewProtocol
extension TimerViewController: TimerViewProtocol {
    func start(with session: SessionSetup) {
        presenter?.startTimer(with: session)
    }
    
    func runClock(startSeconds: Int, types: [IntervalType]) {
        intervalTypeLabel.switchType(to: types[0])
        clockView.runClock(with: startSeconds)
        statusIndicatorView.configure(with: types)
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
    }
    
    func pauseClock() {
        clockView.pauseClock()
    }
    
    func resumeClock() {
        clockView.resumeClock()
    }
    
    func enterBackground() {
        presenter?.enterBackground()
    }
    
    func enterForeground() {
        presenter?.enterForeground()
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
    
    @objc
    func clockViewBtnHandler() {
        presenter?.clockViewDidTap()
    }
}
