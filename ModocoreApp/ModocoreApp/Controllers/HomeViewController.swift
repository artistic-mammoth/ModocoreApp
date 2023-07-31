//
//  HomeViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 26.07.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Private properties
    private var currentSession: SessionSetup?
    
    // MARK: - Views
    private lazy var infoTodayFocus = InfoView()
    private lazy var infoAllFocus = InfoView()
    private lazy var weekStreakView = WeekStreakView()
    private lazy var historyView = HistoryView()
    private lazy var startButton = ActiveButton()
    private lazy var setupButton = ActiveButton()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 34)
        label.textColor = .blackBackground
        label.textAlignment = .center
        label.text = Catalog.Names.homeTitle
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLayoutView()
        setupSwipeNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Private extension
private extension HomeViewController {
    func setupAndLayoutView() {
        view.addViews([titleLabel, infoStack, weekStreakView, historyView, startButton, setupButton])
        view.backgroundColor = .white
        
        infoStack.addArrangedSubview(infoTodayFocus)
        infoStack.addArrangedSubview(infoAllFocus)
        
        startButton.labelText = Catalog.Names.startButtonName
        startButton.addTarget(self, action: #selector(startButtonHandle), for: .touchUpInside)
        
        setupButton.labelText = Catalog.Names.setupButtonName
        setupButton.addTarget(self, action: #selector(setupButtonHandle), for: .touchUpInside)
        
        updateInfoViews(DataStorageService.history)
        updateWeekView(DataStorageService.history)
        updateHistoryView(DataStorageService.history)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) { [weak self] in
//            self?.updateHistoryView(DataStorageService.history2)
//            self?.updateInfoViews(DataStorageService.history2)
//            self?.updateWeekView(DataStorageService.history2)
//        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            infoStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoStack.heightAnchor.constraint(equalToConstant: 130),
            
            weekStreakView.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 30),
            weekStreakView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            weekStreakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            weekStreakView.heightAnchor.constraint(equalToConstant: 100),
            
            historyView.topAnchor.constraint(equalTo: weekStreakView.bottomAnchor, constant: 15),
            historyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            historyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            historyView.heightAnchor.constraint(equalToConstant: 100),
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            startButton.widthAnchor.constraint(equalToConstant: 185),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 56),
            
            setupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            setupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            setupButton.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -8),
            setupButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        let startBtnTopConstraint = startButton.topAnchor.constraint(equalTo: historyView.bottomAnchor, constant: 30)
        startBtnTopConstraint.priority = .defaultHigh
        startBtnTopConstraint.isActive = true
        
        let setupBtnTopConstraint = setupButton.topAnchor.constraint(equalTo: historyView.bottomAnchor, constant: 30)
        setupBtnTopConstraint.priority = .defaultHigh
        setupBtnTopConstraint.isActive = true
    }
    
    func updateInfoViews(_ historyData: HistoryData) {
        infoTodayFocus.titleText = Catalog.Names.infoTodayFocusTitle
        infoAllFocus.titleText = Catalog.Names.infoAllFocusTitle
        infoAllFocus.isBlackTheme = false

        let data = historyData.data
        
        var allFocusSeconds = 0
        var allFocusCount = 0
        
        for i in 0..<data.count {
            allFocusSeconds += data[i].focusSeconds
            allFocusCount += data[i].startingCount
        }

        infoAllFocus.totalSeconds = allFocusSeconds
        infoAllFocus.count = allFocusCount
        
        let todayData = data.last ?? DayData(date: Date.now, startingCount: 0, focusSeconds: 0)
        
        infoTodayFocus.totalSeconds = todayData.focusSeconds
        infoTodayFocus.count = todayData.startingCount
    }
    
    func updateWeekView(_ historyData: HistoryData) {
        var count = 0
        var reversedData = historyData.data
        reversedData.reverse()
        
        let historyCount = reversedData.count <= 7 ? reversedData.count : 7

        for i in 0..<historyCount {
            if reversedData[i].startingCount == 0 {
                break
            }
            else {
                count += 1
            }
        }
        weekStreakView.currentStreak = count
    }
    
    func updateHistoryView(_ historyData: HistoryData) {
        let focusSeconds = historyData.data.map({ $0.focusSeconds })
        historyView.historySeconds = focusSeconds
    }
    
    @objc func startButtonHandle() {
        guard let currentSession = self.currentSession else { return }
        TabBarController.shared.switchTabTo(1)
        TabBarController.shared.timerController.startTimer(with: currentSession)
    }
    
    @objc func setupButtonHandle() {
        let setupViewController = SetupViewController()
        setupViewController.doneAction = { [weak self] session in
            self?.currentSession = session
        }
        navigationController?.present(setupViewController, animated: true)
    }
    
    func setupSwipeNavigation() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            TabBarController.shared.switchTabTo(self.tabBarController!.selectedIndex + 1)
        }
        if sender.direction == .right {
            TabBarController.shared.switchTabTo(self.tabBarController!.selectedIndex - 1)
        }
    }
}
