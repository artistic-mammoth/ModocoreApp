//
//  CounterController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

final class CounterService {
    // MARK: - Public properties
    weak var delegate: CounterDelegate?
    
    // MARK: - Private properties
    private var currentTime = 0
    private weak var timer: Timer?
    private var currentSessionIndex = 0
    private var session: [TimerParameters]
    
    // MARK: - Init
    init(_ params: [TimerParameters]) {
        session = params
    }
    
    // MARK: - Public methods
    func startCounter() {
        guard session.count > 0 else { delegate = nil; return }
        currentSessionIndex = 0
        currentTime = session[0].timeInSec
        delegate?.startTimer(with: session[0])
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    func resumeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
}

// MARK: - Private extension
private extension CounterService {
    @objc func timerAction() {
        if currentTime >= 0 {
            delegate?.updateTime(with: currentTime)
            currentTime -= 1
        }
        else {
            switchOrStop()
        }
    }
    
    func switchOrStop() {
        currentSessionIndex += 1
        if currentSessionIndex >= session.count {
            delegate?.stopTimer()
            timer?.invalidate()
            return
        }
        currentTime = session[currentSessionIndex].timeInSec
        delegate?.switchState(with: session[currentSessionIndex])
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
}
