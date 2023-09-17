//
//  HomeViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 26.07.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func updateInfoTodayFocus(totalSeconds: Int, count: Int)
    func updateInfoAllFocus(totalSeconds: Int, count: Int)
    func updateWeekStreakView(with currentStreak: Int)
    func updateHistoryView(with historySeconds: [Int])
}

final class HomeViewController: UIViewController {
    // MARK: - Public properties
    var presenter: HomePresenterProtocol?
    
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
    override func loadView() {
        super.loadView()
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func updateInfoTodayFocus(totalSeconds: Int, count: Int) {
        infoTodayFocus.totalSeconds = totalSeconds
        infoTodayFocus.count = count
    }
    
    func updateInfoAllFocus(totalSeconds: Int, count: Int) {
        infoAllFocus.totalSeconds = totalSeconds
        infoAllFocus.count = count
    }
    
    func updateWeekStreakView(with currentStreak: Int) {
        weekStreakView.currentStreak = currentStreak
    }
    
    func updateHistoryView(with historySeconds: [Int]) {
        historyView.historySeconds = historySeconds
    }
}

// MARK: - Private extension
private extension HomeViewController {
    func configureView() {
        view.addViews(titleLabel, infoStack, weekStreakView, historyView, startButton, setupButton)
        infoStack.addArrangedSubview(infoTodayFocus)
        infoStack.addArrangedSubview(infoAllFocus)
        
        view.backgroundColor = .white

        infoTodayFocus.titleText = Catalog.Names.infoTodayFocusTitle
        infoAllFocus.titleText = Catalog.Names.infoAllFocusTitle
        infoAllFocus.isBlackTheme = false
        
        startButton.labelText = Catalog.Names.startButtonName
        setupButton.labelText = Catalog.Names.setupButtonName
        setupButtonActions()
        
        setupSwipeNavigation()
        setupLayout()
    }
    
    func setupButtonActions() {
        let startButtonAction = UIAction { [weak self] _ in
            self?.presenter?.startButtonDidTap()
        }
        
        let setupButtonAction = UIAction { [weak self] _ in
            self?.presenter?.setupButtonDidTap()
        }
        
        startButton.addAction(startButtonAction, for: .touchUpInside)
        setupButton.addAction(setupButtonAction, for: .touchUpInside)
    }
    
    func setupLayout() {
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
}
