//
//  Date+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 31.07.2023.
//

import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        self.init(timeInterval: 0, since: date)
    }
    
    init(_ string: String, format: String = "yyyy-MM-dd") {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        self.init(timeInterval: 0, since: date)
    }
}
