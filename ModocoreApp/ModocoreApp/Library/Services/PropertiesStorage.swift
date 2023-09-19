//
//  PropertiesStorage.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 19.09.2023.
//

import Foundation

enum StoringKeys: String {
    case lastTimePick = "last-time-pick"
}

enum DataErrors: Error {
    case encodeError
    case decodeError
    case noUserDefaults
}

protocol PropertiesStorageProtocol {
    func saveTimePicked(_ timePicked: TimePicked) throws
    func getTimePicked() throws -> TimePicked?
}

final class PropertiesStorage {
    // MARK: - Singleton
    static let shared: PropertiesStorageProtocol = PropertiesStorage()
    private init() {}
}

// MARK: - PropertiesStorageProtocol
extension PropertiesStorage: PropertiesStorageProtocol {
    func saveTimePicked(_ timePicked: TimePicked) throws {
        let userDefaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(timePicked)
            userDefaults.set(data, forKey: StoringKeys.lastTimePick.rawValue)
            userDefaults.synchronize()
        } catch {
            throw(DataErrors.encodeError)
        }
    }

    func getTimePicked() throws -> TimePicked? {
        let userDefaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        guard let data = userDefaults.object(forKey: StoringKeys.lastTimePick.rawValue) as? Data else {
            throw(DataErrors.noUserDefaults)
        }
        
        do {
            let task = try decoder.decode(TimePicked.self, from: data)
            return task
        } catch {
            throw(DataErrors.decodeError)
        }
    }
}
