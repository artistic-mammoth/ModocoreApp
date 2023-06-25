//
//  TimerParameters.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

enum TimerStatus {
    case focus
    case rest
}

struct TimerParameters {
    let status: TimerStatus
    let timeInSec: Int
    
    init(status: TimerStatus, timeInSec: Int) {
        self.status = status
        self.timeInSec = timeInSec
    }
}
