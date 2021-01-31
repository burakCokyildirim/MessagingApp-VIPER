//
//  CoreDataService.swift
//  AdessoProjectTemplate
//
//  Created by Zafer Caliskan on 8.01.2018.
//  Copyright © 2018 adesso. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService: CoreDataServiceProtocol {

    static let sharedInstance = CoreDataService()
    private init() {}

    // MARK: - Delegate

    func update() -> Bool {
        do {
            try managedObjectContext.save()

            return true
        } catch {}

        return false
    }

    func delete(managedObject _: NSManagedObject) -> Bool {
        do {
            try managedObjectContext.save()

            return true
        } catch {}

        return false
    }

    // MARK: - CoreData Stack

    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "MACFitDataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("MACFitDataModel")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }

        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {

        var managedObjectContext: NSManagedObjectContext?
        //        if #available(iOS 10.0, *) {
        //            managedObjectContext = self.persistentContainer.viewContext
        //        } else {
        let coordinator = self.persistentStoreCoordinator
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext?.persistentStoreCoordinator = coordinator

        //        }
        return managedObjectContext!
    }()

    // iOS-10
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MACFitDataModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        print("\(self.applicationDocumentsDirectory)")
        return container
    }()

    // MARK: Core Data Saving support

    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
