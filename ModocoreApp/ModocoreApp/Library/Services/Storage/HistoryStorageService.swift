//
//  HistoryStorageService.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 31.07.2023.
//

import Foundation
import CoreData

protocol HistoryStorageServiceProtocol {
    func loadHistoryData(completion: @escaping ((Result<HistoryData, Error>) -> ()))
    func updateFocusSeconds(_ secondsToAdd: Int)
    func addStartingCount(_ startingToAdd: Int)
}

final class HistoryStorageService {
    // MARK: - Private properties
    private var coreDataStack: CoreDataStackProtocol
    
    // MARK: - Init
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
}

// MARK: - HistoryStorageServiceProtocol
extension HistoryStorageService: HistoryStorageServiceProtocol {
    func loadHistoryData(completion: @escaping ((Result<HistoryData, Error>) -> ())) {
        let fetchRequest: NSFetchRequest<DayData> = DayData.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(DayData.date), ascending: false)
        fetchRequest.sortDescriptors = [sortByDate]
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            completion(.success(results))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func updateFocusSeconds(_ secondsToAdd: Int) {
        updateDay(focusSecondsToAdd: secondsToAdd)
    }
    
    func addStartingCount(_ startingToAdd: Int = 1) {
        updateDay(startingCountToAdd: startingToAdd)
    }
}

// MARK: - Private extension
private extension HistoryStorageService {
    func updateDay(date: Date = Date(), focusSecondsToAdd: Int? = nil, startingCountToAdd: Int? = nil) {
        let context = coreDataStack.managedContext
        let fetchRequest: NSFetchRequest<DayData> = DayData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", date.toString())
        
        let dayData: DayData!
        
        let results = try? context.fetch(fetchRequest)
        
        if results?.count == 0 {
            dayData = DayData(context: context)
            dayData.date = date.toString()
        } else {
            dayData = results?.first
        }
        
        if let focusSecondsToAdd = focusSecondsToAdd {
            dayData.focusSeconds += Int32(focusSecondsToAdd)
        }
        
        if let startingCountToAdd = startingCountToAdd {
            dayData.startingCount += Int32(startingCountToAdd)
        }
        
        coreDataStack.saveContext()
    }
}
