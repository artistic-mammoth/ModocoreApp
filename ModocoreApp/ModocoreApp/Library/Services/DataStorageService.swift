//
//  DataStorageService.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 31.07.2023.
//

import Foundation

final class DataStorageService {
    static let history: HistoryData = HistoryData(data: [
        DayData(date: Date("2023-07-14"), startingCount: 7, focusSeconds: 10500),
        DayData(date: Date("2023-07-15"), startingCount: 4, focusSeconds: 2400),
        DayData(date: Date("2023-07-16"), startingCount: 8, focusSeconds: 7000),
        DayData(date: Date("2023-07-17"), startingCount: 2, focusSeconds: 3000),
        DayData(date: Date("2023-07-18"), startingCount: 2, focusSeconds: 3000),
        DayData(date: Date("2023-07-19"), startingCount: 5, focusSeconds: 8600),
        DayData(date: Date("2023-07-20"), startingCount: 12, focusSeconds: 14000),
        DayData(date: Date("2023-07-21"), startingCount: 14, focusSeconds: 16000),
        DayData(date: Date("2023-07-22"), startingCount: 0, focusSeconds: 0),
        DayData(date: Date("2023-07-23"), startingCount: 0, focusSeconds: 0),
        DayData(date: Date("2023-07-24"), startingCount: 3, focusSeconds: 4500),
        DayData(date: Date("2023-07-25"), startingCount: 4, focusSeconds: 5000),
        DayData(date: Date("2023-07-26"), startingCount: 0, focusSeconds: 0),
        DayData(date: Date("2023-07-27"), startingCount: 6, focusSeconds: 6000),
        DayData(date: Date("2023-07-28"), startingCount: 6, focusSeconds: 4000),
        DayData(date: Date("2023-07-29"), startingCount: 3, focusSeconds: 3700),
        DayData(date: Date("2023-07-30"), startingCount: 0, focusSeconds: 0),
        DayData(date: Date("2023-07-31"), startingCount: 3, focusSeconds: 3500),
        
    ])
    
    static let history2: HistoryData = HistoryData(data: [
        DayData(date: Date("2023-07-29"), startingCount: 3, focusSeconds: 3700),
        DayData(date: Date("2023-07-30"), startingCount: 1, focusSeconds: 1000),
        DayData(date: Date("2023-07-31"), startingCount: 3, focusSeconds: 3500),
        
    ])
}
