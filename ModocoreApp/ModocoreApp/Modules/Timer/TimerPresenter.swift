//
//  TimerPresenter.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 08.09.2023.
//

import Foundation

protocol TimerPresenterProtocol {
    func startTimer(with session: SessionSetup)
    func enterBackground()
    func enterForeground()
    func clockViewDidTap()
}

final class TimerPresenter {
    // MARK: - Public properties
    weak var view: TimerViewProtocol?
    var counterService: CounterServiceProtocol?
    
    // MARK: - Private properties
    private var isPaused = false
    private var isStarted = false
    
    // MARK: - Init
    init(view: TimerViewProtocol? = nil, counterService: CounterServiceProtocol? = nil) {
        self.view = view
        self.counterService = counterService
    }
}

// MARK: - TimerPresenterProtocol
extension TimerPresenter: TimerPresenterProtocol {
    func startTimer(with session: SessionSetup) {
        guard !isStarted else { return }
        
        isStarted = true
        counterService?.runCounter(with: session)
    }
    
    func enterBackground() {
        guard counterService != nil && !isPaused else { return }
        counterService?.enterBackground()
    }
    
    func enterForeground() {
        guard counterService != nil && !isPaused else { return }
        counterService?.enterForeground()
    }
    
    func clockViewDidTap() {
        guard isStarted else { return }

        if isPaused {
            counterService?.resumeTimer()
            view?.resumeClock()
            isPaused = false
        }
        else {
            counterService?.pauseTimer()
            view?.pauseClock()
            isPaused = true
        }
    }
}

// MARK: - ClockDelegate
extension TimerPresenter: ClockDelegate {
    func runClock(with setup: SessionSetup) {
        let types = setup.map( { $0.type } )
        let startSeconds = setup[0].seconds
        view?.runClock(startSeconds: startSeconds, types: types)
    }
    
    func updateClockTime(_ seconds: Int) {
        view?.updateClockTime(seconds)
    }
    
    func updateClock(with param: IntervalParameters, skipFor: Int) {
        view?.updateClock(with: param, skipFor: skipFor)
    }
    
    func stopClock() {
        view?.stopClock()
        isStarted = false
    }
}
