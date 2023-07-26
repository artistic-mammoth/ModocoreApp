//
//  CounterController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

final class CounterService {
    // MARK: - Public properties
    weak var delegate: ClockDelegate?
    
    // MARK: - Private properties
    private var currentTime = 0
    private weak var timer: Timer?
    private var currentIntervalIndex = 0
    private var setup: SessionSetup
    
    // MARK: - Init
    init(_ setup: SessionSetup) {
        self.setup = setup
    }
    
    // MARK: - Public methods
    func runCounter() {
        guard setup.session.count > 0 else { delegate = nil; return }
        currentIntervalIndex = 0
        currentTime = setup.session[0].seconds
        delegate?.runClock(with: setup)
        runTimer()
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    func resumeTimer() {
        runTimer()
    }
}

// MARK: - Private extension
private extension CounterService {
    func runTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if currentTime >= 1 {
            currentTime -= 1
            delegate?.updateClockTime(currentTime)
        }
        else {
            checkoutState()
        }
    }
    
    func checkoutState() {
        currentIntervalIndex += 1
        
        if currentIntervalIndex >= setup.session.count {
            delegate?.stopClock()
            stopTimer()
            return
        }
        
        currentTime = setup.session[currentIntervalIndex].seconds
        delegate?.updateClock(with: setup.session[currentIntervalIndex])
        runTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
