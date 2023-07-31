//
//  SetupScreenPickerView.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 27.07.2023.
//

import UIKit

final class SetupPickerView: UIView {
    // MARK: - Public properties
    /// Callback when picked
    public var onPickedHandler: ((_ amount: Int) -> Void)?
    
    // MARK: - Private properties
    private var currentType: PickerType
    private var labelText: String
    
    private lazy var selectedMinutes: Int = 0
    private lazy var selectedSeconds: Int = 1
    
    // MARK: - Views
    private lazy var pickerView = UIPickerView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldInter(size: 24)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldInter(size: 60)
        label.textColor = .white
        label.alpha = 0.8
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.text = ":"
        return label
    }()
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init(type: PickerType, labelText: String) {
        self.currentType = type
        self.labelText = labelText
        super.init(frame: .zero)
        setupAndLayoutView()
    }
}

// MARK: - Private extension
private extension SetupPickerView {
    func setupAndLayoutView() {
        titleLabel.text = labelText
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.backgroundColor = .blackBackground
        pickerView.layer.cornerRadius = 24
        pickerView.clipsToBounds = true
        
        addViews([titleLabel, pickerView])
        
        if currentType == .timePicker { setupForTimeType() }
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: pickerView.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func getPickerCell() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldInter(size: 60)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
    
    func getLabelForSection(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .regularInter(size: 15)
        label.textColor = .white
        label.alpha = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
    
    func setupForTimeType() {
        let minLabel = getLabelForSection(with: Catalog.Names.timePrefixMinutesName)
        let secLabel = getLabelForSection(with: Catalog.Names.timePrefixSecondsName)
        
        addViews([separatorLabel,minLabel, secLabel])
        
        pickerView.selectRow(1, inComponent: 1, animated: true)
        
        NSLayoutConstraint.activate([
            separatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorLabel.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor, constant: -3),
            separatorLabel.widthAnchor.constraint(equalToConstant: 15),
            separatorLabel.heightAnchor.constraint(equalToConstant: 60),
            
            minLabel.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor, constant: 15),
            minLabel.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: 10),
            
            secLabel.trailingAnchor.constraint(equalTo: pickerView.trailingAnchor,constant: -15),
            secLabel.topAnchor.constraint(equalTo: pickerView.topAnchor, constant: 10)
        ])
    }
}

// MARK: - UIPickerViewDelegate and UIPickerViewDataSource
extension SetupPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentType {
        case .timePicker:
            return 60
        case .amountPicker:
            return 5
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch currentType {
        case .timePicker:
            return 2
        case .amountPicker:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.subviews.last?.backgroundColor = .clear
        
        switch currentType {
        case .timePicker:
            if component == 0 {
                selectedMinutes = row
            }
            else if component == 1 {
                selectedSeconds = row
            }
            
            if selectedMinutes == 0 && selectedSeconds == 0 {
                pickerView.selectRow(1, inComponent: 1, animated: true)
                selectedSeconds = 1
                return
            }
            
            let totalSeconds = selectedMinutes * 60 + selectedSeconds
            onPickedHandler?(totalSeconds)
            
        case .amountPicker:
            onPickedHandler?(row + 1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews.last?.backgroundColor = .clear
        let label = getPickerCell()
        
        switch currentType {
        case .timePicker:
            label.text = String(format: "%02d", row)
        case .amountPicker:
            label.text = String(row + 1)
        }
        
        return label
    }
}
