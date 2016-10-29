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
    var managedObjectContext: NSManagedObjectContext
    
    override init()
    {
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension:"momd") else
        {
            fatalError("Error loading model from bundle")
        }
     
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else
        {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
    }
}
