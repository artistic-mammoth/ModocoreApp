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
    
    private lazy var weekStreakView = WeekStreakView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLayoutView()
        setupSwipeNavigation()
    }
}

// MARK: - Private extension
private extension HomeViewController {
    func setupAndLayoutView() {
        view.addViews([startButton, setupButton, infoTodayFocus, infoStack, weekStreakView])
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
        
        weekStreakView.currentStreak = 3
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            startButton.widthAnchor.constraint(equalToConstant: 185),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 56),
            
            setupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            setupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            setupButton.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -8),
            setupButton.heightAnchor.constraint(equalToConstant: 56),
            
            infoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoStack.heightAnchor.constraint(equalToConstant: 130),
            
            weekStreakView.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 35),
            weekStreakView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            weekStreakView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            weekStreakView.heightAnchor.constraint(equalToConstant: 100),
        ])
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
