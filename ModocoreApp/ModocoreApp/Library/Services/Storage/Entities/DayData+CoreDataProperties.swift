//
//  DayData+CoreDataProperties.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 09.09.2023.
//
//

import Foundation
import CoreData


extension DayData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayData> {
        return NSFetchRequest<DayData>(entityName: "DayData")
    }

    @NSManaged public var date: String
    @NSManaged public var focusSeconds: Int32
    @NSManaged public var startingCount: Int32

}

extension DayData : Identifiable {

}
