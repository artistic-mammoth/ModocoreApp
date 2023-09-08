//
//  CoreDataStack.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 09.09.2023.
//

import CoreData

protocol CoreDataStackProtocol {
    var managedContext: NSManagedObjectContext { get set }
    func saveContext()
}

class CoreDataStack: CoreDataStackProtocol {
    // MARK: - Private properties
    private let modelName: String
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    // MARK: - Public properties
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    // MARK: - Init
    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Public methods
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
