//
//  CounterController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

protocol ClockDelegate: AnyObject {
    func runClock(with setup: SessionSetup)
    func updateClockTime(_ seconds: Int)
    func updateClock(with param: IntervalParameters, skipFor: Int)
    func stopClock()
}

protocol CounterServiceProtocol {
    func runCounter(with setup: SessionSetup)
    func pauseTimer()
    func resumeTimer()
    func enterBackground()
    func enterForeground()
}

final class CounterService {
    // MARK: - Public properties
    weak var delegate: ClockDelegate?
    
    // MARK: - Private properties
    private var currentTime: Int = 0
    private weak var timer: Timer?
    private var currentIntervalIndex = 0
    private var setup: SessionSetup?
    
    private var timeEnterBackground: Date = Date()
    
    // MARK: - Init
    init(delegate: ClockDelegate? = nil) {
        self.delegate = delegate
    }
}

// MARK: - CounterServiceProtocol
extension CounterService: CounterServiceProtocol {
    func runCounter(with setup: SessionSetup) {
        self.setup = setup
        guard setup.count > 0 else { delegate = nil; return }
        currentIntervalIndex = 0
        currentTime = setup[0].seconds
        delegate?.runClock(with: setup)
        runTimer()
        NotificationService.shared.updateNotificationForTimer(setup: setup, currentTime: currentTime, currentIntervalIndex: currentIntervalIndex)
    }
    
    func pauseTimer() {
        timer?.invalidate()
        NotificationService.shared.removeTimerNotifications()
    }
    
    func resumeTimer() {
        guard let setup = setup else { return }
        runTimer()
        NotificationService.shared.updateNotificationForTimer(setup: setup, currentTime: currentTime, currentIntervalIndex: currentIntervalIndex)
    }
    
    func enterBackground() {
        timeEnterBackground = .now
        stopTimer()
    }
    
    func enterForeground() {
        guard let setup = setup else { return }
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
            
            for i in currentIntervalIndex...setup.count {
                currentIntervalIndex = i
                if currentIntervalIndex >= setup.count {
                    delegate?.stopClock()
                    NotificationService.shared.removeTimerNotifications()
                    stopTimer()
                    break
                }
                
                let sessionTime = setup[i].seconds
                if time >= sessionTime {
                    time -= sessionTime
                    skipFor += 1
                    continue
                }
                else {
                    currentTime = setup[i].seconds - time
                    delegate?.updateClock(with: setup[i], skipFor: skipFor)
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
        guard let setup = setup else { return }
        currentIntervalIndex += 1
        
        if currentIntervalIndex >= setup.count {
            delegate?.stopClock()
            NotificationService.shared.removeTimerNotifications()
            stopTimer()
            return
        }
        
        currentTime = setup[currentIntervalIndex].seconds
        delegate?.updateClock(with: setup[currentIntervalIndex], skipFor: 1)
        runTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
