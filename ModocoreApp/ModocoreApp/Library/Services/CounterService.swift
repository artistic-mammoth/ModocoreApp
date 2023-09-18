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

protocol CounterServiceProtocol: Lifecycleable {
    func runCounter(with setup: SessionSetup)
    func pauseTimer()
    func resumeTimer()
}

final class CounterService {
    // MARK: - Public properties
    weak var delegate: ClockDelegate?
    
    // MARK: - Private properties
    private var currentTime: Int = 0
    private var currentIntervalIndex = 0
    private var setup: SessionSetup?

    private weak var timer: Timer?
    private var timeEnterBackground: Date?
    private var storage: HistoryStorageServiceProtocol
    private var audioService: AudioServiceProtocol?
    
    // MARK: - Init
    init(delegate: ClockDelegate? = nil, storage: HistoryStorageServiceProtocol, audioService: AudioServiceProtocol? = nil) {
        self.delegate = delegate
        self.storage = storage
        self.audioService = audioService
    }
}

// MARK: - CounterServiceProtocol
extension CounterService: CounterServiceProtocol {
    func runCounter(with setup: SessionSetup) {
        guard setup.count > 0 else { return }
        
        self.setup = setup
        currentIntervalIndex = 0
        currentTime = setup[0].seconds
        runTimer()
        
        delegate?.runClock(with: setup)
        updateNotifications(setup: setup)
        storage.addStartingCount(1)
    }
    
    func pauseTimer() {
        stopTimer()
        removeNotifications()
    }
    
    func resumeTimer() {
        guard let setup = setup else { return }
        runTimer()
        updateNotifications(setup: setup)
    }
    
    func appEnterBackground() {
        timeEnterBackground = .now
        stopTimer()
    }
    
    func appEnterForeground() {
        guard let timeEnterBackground = timeEnterBackground else { return }
        let timeOffline = Date().timeIntervalSince(timeEnterBackground)
        let timeLeft = currentTime - Int(timeOffline)
        
        if timeLeft >= 1 {
            currentTime = timeLeft
            delegate?.updateClockTime(currentTime)
            runTimer()
        } else {
            updateDependsOnOfflineTime(timeLeft: abs(timeLeft))
        }
    }
}

// MARK: - Private extension
private extension CounterService {
    @objc
    func timerAction() {
        if currentTime > 0 {
            currentTime -= 1
            delegate?.updateClockTime(currentTime)
        }
        else {
            audioService?.playAlertForEndOfState()
            checkoutState()
        }
    }
    
    func checkoutState() {
        guard let setup = setup else { return }
        let nextIndex = currentIntervalIndex + 1
        
        if nextIndex >= setup.count {
            stopTimer()
            delegate?.stopClock()
            removeNotifications()
            updateStorage(setup: setup, index: currentIntervalIndex)
            return
        }
        
        currentTime = setup[nextIndex].seconds
        delegate?.updateClock(with: setup[nextIndex], skipFor: 1)
        runTimer()
        updateStorage(setup: setup, index: currentIntervalIndex)
        currentIntervalIndex = nextIndex
    }
    
    func updateDependsOnOfflineTime(timeLeft: Int) {
        guard let setup = setup else { return }
        
        var timeLeft = timeLeft
        let nextIndex = currentIntervalIndex + 1
        var skipFor = 1
        
        for checkIndex in nextIndex...setup.count {
            if checkIndex >= setup.count {
                stopTimer()
                delegate?.stopClock()
                removeNotifications()
                updateStorage(setup: setup, index: checkIndex)
                break
            }
            
            let checkIntervalTime = setup[checkIndex].seconds
            if timeLeft >= checkIntervalTime {
                timeLeft -= checkIntervalTime
                skipFor += 1
                updateStorage(setup: setup, index: checkIndex)
                continue
            } else {
                currentTime = checkIntervalTime - timeLeft
                currentIntervalIndex = checkIndex
                delegate?.updateClock(with: setup[checkIndex], skipFor: skipFor)
                delegate?.updateClockTime(currentTime)
                runTimer()
                updateStorage(setup: setup, index: checkIndex - 1)
                updateNotifications(setup: setup)
                break
            }
        }
    }
    
    func runTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func updateNotifications(setup: SessionSetup) {
        NotificationService.shared.updateNotificationForTimer(setup: setup, currentTime: currentTime, currentIntervalIndex: currentIntervalIndex)
    }
    
    func removeNotifications() {
        NotificationService.shared.removeTimerNotifications()
    }
    
    func updateStorage(setup: SessionSetup, index: Int) {
        guard index < setup.count && index >= 0 else { return }
        if setup[index].type == .focus {
            let seconds = setup[index].seconds
            storage.updateFocusSeconds(seconds)
        }
    }
}
