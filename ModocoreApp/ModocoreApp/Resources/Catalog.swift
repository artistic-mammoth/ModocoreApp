//
//  Catalog.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.07.2023.
//

import UIKit

enum Catalog {
    static let circleShapeParameters: [CircleShapeParameters] = [
        CircleShapeParameters(powAmplitude: 3, powDynamics: 4, waveAmplitude: 50, diameter: 300, frequency: 8, speed: 1 / 500.0, opacity: 0.25, color: .circleAndTextBlue),
        CircleShapeParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 11, diameter: 300, frequency: 6, speed: 1 / 500.0, opacity: 0.50, color: .circleAndTextBlue),
        CircleShapeParameters(powAmplitude: 3, powDynamics: 4, waveAmplitude: 5, diameter: 300, frequency: 4, speed: 1 / 1000.0, opacity: 0.75, color: UIColor.white),
        CircleShapeParameters(powAmplitude: 9, powDynamics: 10, waveAmplitude: 20, diameter: 300, frequency: 5, speed: 1 / 1000.0, opacity: 1, color: UIColor.white)
    ]
    
    enum Names {
        static let homeTitle: String = "Welcome"
        static let historyTitle: String = "Focus history"
        static let weekStreakTitle: String = "Week streak"
        static let focusPickerTitle: String = "FOCUS TIME"
        static let restPickerTitle: String = "REST TIME"
        static let repeatsPickerTitle: String = "REPEATS"
        static let infoTodayFocusTitle: String = "Today focus"
        static let infoAllFocusTitle: String = "All focus"
        
        static let startButtonName: String = "START"
        static let setupButtonName: String = "Setup\ntimer"
        static let doneButtonName: String = "DONE"
        
        static let focusName: String = "FOCUS"
        static let restName: String = "REST"
        static let timePrefixHoursName: String = "h"
        static let timePrefixMinutesName: String = "min"
        static let timePrefixSecondsName: String = "sec"
    }
}
