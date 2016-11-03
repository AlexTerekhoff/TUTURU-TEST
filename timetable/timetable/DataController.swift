//
//  DataController.swift
//  timetable
//
//  Created by Alexander on 29/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject
{
    static let sharedInstance = DataController()
    var managedObjectContext: NSManagedObjectContext?
    
    override init()
    {
        super.init()
        setup()
    }
    
    func setup()
    {
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let storeCoordinator = createStoreCoordinator()
        managedObjectContext!.persistentStoreCoordinator = storeCoordinator
        setupStoreForStoreCoordinator(coordinator: storeCoordinator)
    }
    
    func createStoreCoordinator() -> NSPersistentStoreCoordinator
    {
        guard let modelURL = Bundle.main.url(forResource:"Model",
                                          withExtension:"momd") else
        {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else
        {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        return psc
    }
    
    func setupStoreForStoreCoordinator(coordinator: NSPersistentStoreCoordinator)
    {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        let storeURL = docURL.appendingPathComponent("Model.sqlite")
        print(storeURL)
        do
        {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                   configurationName: nil,
                                                  at: storeURL,
                                             options: nil)
        }
        catch
        {
            fatalError("Error migrating store: \(error)")
        }
    }
    
}
