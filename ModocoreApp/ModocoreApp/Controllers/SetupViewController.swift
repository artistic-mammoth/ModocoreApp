//
//  SetupViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 26.07.2023.
//

import UIKit

final class SetupViewController: UIViewController {
    // MARK: - Public properties
    /// Callback when done editing
    public var doneAction: ((_ session: SessionSetup) -> Void)?
    
    // MARK: - Private properties
    private lazy var currentFocusSeconds: Int = 1
    private lazy var currentRestSeconds: Int = 1
    private lazy var currentRepeatsTimes: Int = 1
    
    // MARK: - Views
    private lazy var focusPickerView = SetupPickerView(type: .timePicker, labelText: Catalog.Names.focusPickerTitle)
    private lazy var restPickerView = SetupPickerView(type: .timePicker, labelText: Catalog.Names.restPickerTitle)
    private lazy var repeatsPickerView = SetupPickerView(type: .amountPicker, labelText: Catalog.Names.repeatsPickerTitle)
    
    private lazy var doneButton = ActiveButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLayoutView()
        setupHandlers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        doneButtonHandler()
    }
}

// MARK: - Private extension
private extension SetupViewController {
    func setupAndLayoutView() {
        view.addViews([focusPickerView, restPickerView, repeatsPickerView, doneButton])
        view.backgroundColor = .white
        
        doneButton.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        doneButton.BgColor = .blackBackground
        doneButton.labelText = Catalog.Names.doneButtonName
        
        NSLayoutConstraint.activate([
            focusPickerView.heightAnchor.constraint(equalToConstant: 140),
            focusPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            focusPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            focusPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            restPickerView.heightAnchor.constraint(equalToConstant: 140),
            restPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            restPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            restPickerView.topAnchor.constraint(equalTo: focusPickerView.bottomAnchor, constant: 30),
            
            repeatsPickerView.heightAnchor.constraint(equalToConstant: 140),
            repeatsPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            repeatsPickerView.widthAnchor.constraint(equalToConstant: 170),
            repeatsPickerView.topAnchor.constraint(equalTo: restPickerView.bottomAnchor, constant: 30),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func setupHandlers() {
        focusPickerView.onPickedHandler = { [weak self] seconds in
            self?.currentFocusSeconds = seconds
        }
        
        restPickerView.onPickedHandler = { [weak self] seconds in
            self?.currentRestSeconds = seconds
        }
        
        repeatsPickerView.onPickedHandler = { [weak self] amount in
            self?.currentRepeatsTimes = amount
        }
    }
    
    @objc func doneButtonHandler() {
        var intervalParameters: [IntervalParameters] = []
        for _ in 0..<currentRepeatsTimes {
            let focus = IntervalParameters(type: .focus, seconds: currentFocusSeconds)
            let rest = IntervalParameters(type: .rest, seconds: currentRestSeconds)
            intervalParameters.append(focus)
            intervalParameters.append(rest)
        }
        doneAction?(SessionSetup(session: intervalParameters))
        dismiss(animated: true)
    }
}
