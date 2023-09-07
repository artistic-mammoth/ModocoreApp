//
//  HomePresenter.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 06.09.2023.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func startButtonDidTap()
    func setupButtonDidTap()
}

final class HomePresenter {
    // MARK: - Public properties
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol
    
    // MARK: - Private properties
    private var currentSession: SessionSetup?
    
    // MARK: - Init
    init(view: HomeViewProtocol? = nil, router: HomeRouterProtocol) {
        self.view = view
        self.router = router
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func setupButtonDidTap() {
        router.openSetupView { [weak self] session in
            self?.currentSession = session
        }
    }
    
    func startButtonDidTap() {
        guard let currentSession = self.currentSession else { return }
        router.openTimerViewWith(session: currentSession)
    }
    
    func viewDidLoaded() {
        NotificationService.shared.checkForNotificationPremission()
        let data = DataStorageService.history
        updateViewData(data)
    }
    
}

// MARK: - Private extension
private extension HomePresenter {
    func updateViewData(_ data: HistoryData) {
        let historyViewData = prepareHistoryViewData(data)
        view?.updateHistoryView(with: historyViewData)
        
        let weekStreakData = prepareWeekViewData(data)
        view?.updateWeekStreakView(with: weekStreakData)
        
        let infoTodayFocusData = prepareInfoTodayFocusData(data)
        view?.updateInfoTodayFocus(totalSeconds: infoTodayFocusData.0, count: infoTodayFocusData.1)
        
        let infoAllFocusData = prepareInfoAllFocusData(data)
        view?.updateInfoAllFocus(totalSeconds: infoAllFocusData.0, count: infoAllFocusData.1)
    }
    
    func prepareHistoryViewData(_ data: HistoryData) -> [Int] {
        data.map({ $0.focusSeconds })
    }
    
    func prepareWeekViewData(_ data: HistoryData) -> Int {
        var count = 0
        var reversedData = data
        reversedData.reverse()
        
        let historyCount = reversedData.count <= 7 ? reversedData.count : 7
        
        for i in 0..<historyCount {
            guard reversedData[i].startingCount != 0 else { break }
            count += 1
        }
        
        return count
    }
    
    func prepareInfoTodayFocusData(_ data: HistoryData) -> (Int, Int) {
        let todayData = data.last ?? DayData(date: Date.now, startingCount: 0, focusSeconds: 0)
        return (todayData.focusSeconds, todayData.startingCount)
    }
    
    func prepareInfoAllFocusData(_ data: HistoryData) -> (Int, Int) {
        var allFocusSeconds = 0
        var allFocusCount = 0
        
        for i in 0..<data.count {
            allFocusSeconds += data[i].focusSeconds
            allFocusCount += data[i].startingCount
        }
        
        return (allFocusSeconds, allFocusCount)
    }
}
