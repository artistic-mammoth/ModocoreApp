//
//  HistoryData.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 31.07.2023.
//

import Foundation

struct HistoryData {
    var data: [DayData]
}

extension HistoryData {
    mutating func addDay(data: DayData) {
        self.data.append(data)
    }
}

