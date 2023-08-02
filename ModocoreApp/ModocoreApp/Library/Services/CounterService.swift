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
    private var currentTime: Int = 0
    private weak var timer: Timer?
    private var currentIntervalIndex = 0
    private var setup: SessionSetup
    
    private var timeEnterBackground: Date = Date()
    
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
        NotificationService.shared.updateNotificationForTimer(setup: setup, currentTime: currentTime, currentIntervalIndex: currentIntervalIndex)
    }
    
    func pauseTimer() {
        timer?.invalidate()
        NotificationService.shared.removeTimerNotifications()
    }
    
    func resumeTimer() {
        runTimer()
        NotificationService.shared.updateNotificationForTimer(setup: setup, currentTime: currentTime, currentIntervalIndex: currentIntervalIndex)
    }
    
    func enterBackground() {
        timeEnterBackground = .now
        stopTimer()
    }
    
    func enterForeground() {
        let diff = Date().timeIntervalSince(timeEnterBackground)
        
        currentTime -= Int(diff)
        
        if currentTime >= 1 {
            delegate?.updateClockTime(currentTime)
            runTimer()
        }
        else {
            currentIntervalIndex += 1
            
            var time = abs(currentTime)
            var skipFor = 0
            
            for i in currentIntervalIndex...setup.session.count {
                currentIntervalIndex = i
                if currentIntervalIndex >= setup.session.count {
                    delegate?.stopClock()
                    NotificationService.shared.removeTimerNotifications()
                    stopTimer()
                    break
                }
                
                let sessionTime = setup.session[i].seconds
                if time >= sessionTime {
                    time -= sessionTime
                    skipFor += 1
                    continue
                }
                else {
                    currentTime = setup.session[i].seconds - time
                    delegate?.updateClock(with: setup.session[i], skipFor: skipFor)
                    runTimer()
                    NotificationService.shared.updateNotificationForTimer(setup: setup, currentTime: currentTime, currentIntervalIndex: currentIntervalIndex)
                    break
                }
            }
        }
    }
}

// MARK: - Private extension
private extension CounterService {
    func runTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
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
            NotificationService.shared.removeTimerNotifications()
            stopTimer()
            return
        }
        
        currentTime = setup.session[currentIntervalIndex].seconds
        delegate?.updateClock(with: setup.session[currentIntervalIndex], skipFor: 1)
        runTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
