//
//  DayData.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 31.07.2023.
//

import Foundation

struct DayData {
    let date: Date
    private(set) var startingCount: Int
    private(set) var focusSeconds: Int
    
    init(date: Date, startingCount: Int, focusSeconds: Int) {
        self.date = date
        self.startingCount = startingCount
        self.focusSeconds = focusSeconds
    }
}

extension DayData {
    mutating func updateData(seconds: Int, count: Int = 1) {
        self.startingCount += count
        self.focusSeconds += seconds
    }
}
