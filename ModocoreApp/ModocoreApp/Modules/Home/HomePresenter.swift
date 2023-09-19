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
    func viewWillAppear()
    func updateHomeView()
}

final class HomePresenter {
    // MARK: - Public properties
    weak var view: HomeViewProtocol?
    weak var coordinator: HomeCoordinatorProtocol?
    
    // MARK: - Private properties
    private var currentSession: SessionSetup?
    private var storage: HistoryStorageServiceProtocol
    
    // MARK: - Init
    init(view: HomeViewProtocol? = nil, coordinator: HomeCoordinatorProtocol? = nil, currentSession: SessionSetup? = nil, storage: HistoryStorageServiceProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.currentSession = currentSession
        self.storage = storage
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func viewDidLoaded() {
        NotificationService.shared.checkForNotificationPremission()
        updateHistoryData()
        getSavedParameters()
    }
    
    func startButtonDidTap() {
        guard let currentSession = self.currentSession else { return }
        coordinator?.startTimer(session: currentSession)
    }
    
    func setupButtonDidTap() {
        coordinator?.openSetupView { [weak self] session in
            self?.currentSession = session
        }
    }
    
    func viewWillAppear() {
        updateHistoryData()
    }
    
    func updateHomeView() {
        updateHistoryData()
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
        data.map({ Int($0.focusSeconds) })
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
        guard let todayData = data.last else { return (0, 0)}
        return (Int(todayData.focusSeconds), Int(todayData.startingCount))
    }
    
    func prepareInfoAllFocusData(_ data: HistoryData) -> (Int, Int) {
        var allFocusSeconds = 0
        var allFocusCount = 0
        
        for i in 0..<data.count {
            allFocusSeconds += Int(data[i].focusSeconds)
            allFocusCount += Int(data[i].startingCount)
        }
        
        return (allFocusSeconds, allFocusCount)
    }
    
    func updateHistoryData() {
        storage.loadHistoryData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.updateViewData(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSavedParameters() {
        if let savedData = try? PropertiesStorage.shared.getTimePicked() {
            let session = SessionSetup.calculateWith(repeatTimes: savedData.repeats, focusSeconds: savedData.focusSeconds, restSeconds: savedData.restSeconds)
            self.currentSession = session
        }
    }
}
