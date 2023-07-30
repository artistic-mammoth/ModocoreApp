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
    private lazy var startButton = ActiveButton()
    private lazy var setupButton = ActiveButton()
    
    private lazy var infoTodayFocus = InfoView()
    private lazy var infoAllFocus = InfoView()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldInter(size: 34)
        label.textColor = .blackBackground
        label.textAlignment = .center
        label.text = "Welcome"
        return label
    }()
    
    private lazy var weekStreakView = WeekStreakView()
    
    private lazy var historyView = HistoryView()
    
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
        view.addViews([startButton, setupButton, titleLabel, infoTodayFocus, infoStack, weekStreakView, historyView])
        view.backgroundColor = .white
        
        infoStack.addArrangedSubview(infoTodayFocus)
        infoStack.addArrangedSubview(infoAllFocus)
        
        startButton.labelText = "START"
        startButton.addTarget(self, action: #selector(startButtonHandle), for: .touchUpInside)
        
        setupButton.labelText = "Setup\ntimer"
        setupButton.addTarget(self, action: #selector(setupButtonHandle), for: .touchUpInside)
        
        infoTodayFocus.titleText = "Today focus"
        infoTodayFocus.totalMinutes = 8
        infoTodayFocus.count = 10
        
        infoAllFocus.titleText = "All focus"
        infoAllFocus.totalMinutes = 150
        infoAllFocus.count = 43
        infoAllFocus.isBlackTheme = false
                        
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
