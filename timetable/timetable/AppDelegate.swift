//
//  AppDelegate.swift
//  timetable
//
//  Created by Alexander on 24/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var dataController: DataController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        dataController = DataController.init()
        uploadData ()
        return true
    }

    func uploadData ()
    {
        let url = Bundle.main.url(forResource: "allStations", withExtension: "json")
        do
        {
            let data = try Data.init(contentsOf: url!)
            
            let jsonDictionary = try JSONSerialization.jsonObject(with: data) as! Dictionary< String, Array <Dictionary<String, AnyObject>>>
            
            let citiesFrom = jsonDictionary["citiesFrom"]
            
            for city in citiesFrom!
            {
                let title = city["cityTitle"] as! String
                let entity = NSEntityDescription.insertNewObject(forEntityName: "City",
                                                                          into: dataController!.managedObjectContext)
                entity.setValue(title, forKey: "cityTitle")
                
                do
                {
                    try dataController!.managedObjectContext.save()
                }
                catch
                {
                    fatalError("Failure to save context: \(error)")
                }
            }
        }
        catch
        {
            fatalError("Error in uploading data");
        }
    }
}
