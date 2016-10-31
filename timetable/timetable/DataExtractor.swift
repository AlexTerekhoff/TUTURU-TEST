//
//  DataExtractor.swift
//  timetable
//
//  Created by Alexander on 31/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData

class DataExtractor: NSObject
{
    let citiesFromKey = "citiesFrom"
    let citiesToKey = "citiesTo"
    let cityKey = "City"
    let pointKey = "Point"
    let stationKey = "Station"
    
    typealias JSONDataType = Dictionary< String, Array <Dictionary<String, AnyObject>>>
    
    private var dataController:DataController?
    
    override init()
    {
        super.init()
        setup()
    }
    
    func setup()
    {
        dataController = DataController.sharedInstance
    }
    
    ////
    func uploadDataFromJSONDataStore()
    {
        let url = Bundle.main.url(forResource: "allStations",
                               withExtension: "json")
        do
        {
            let data = try Data.init(contentsOf: url!)
            let jsonDictionary = try JSONSerialization.jsonObject(with: data) as! JSONDataType
            importCitiesFromJSONDictionaryToPersisitentStore(jsonDictionary:jsonDictionary)
        }
        catch
        {
            fatalError("Error in uploading data");
        }
    }
    
    func importCitiesFromJSONDictionaryToPersisitentStore (jsonDictionary:JSONDataType)
    {
        parseCitiesFrom(jsonDictionary:jsonDictionary,
                        cityKey:citiesFromKey)
    }
    
    
    func parseCitiesFrom(jsonDictionary:JSONDataType,
                         cityKey:String)
    {
        let entityCity = NSEntityDescription.insertNewObject(forEntityName:"City",
                                                                    into: dataController!.managedObjectContext!)
//        let entityPoint = NSEntityDescription.insertNewObject(forEntityName:pointKey,
//                                                                     into: dataController!.managedObjectContext!)
//        let entityStation = NSEntityDescription.insertNewObject(forEntityName:stationKey,
//                                                                       into: dataController!.managedObjectContext!)
        let cities = jsonDictionary[cityKey]
        for city in cities!
        {
            //let id = city["cityId"] as! NSNumber
            let name = city["cityTitle"] as! String
//            let country = city["cityTitle"] as! String
//            let district = city["districtTitle"] as! String
//            let region = city["regionTitle"] as! String
            
            entityCity.setValue(name, forKey:"name")
//            entityCity.setValue(id, forKey:"id")
//            entityCity.setValue(country, forKey:"district")
//            entityCity.setValue(district, forKey:"region")
//            entityCity.setValue(region, forKey:"country")
            
            //parse point
            //parse stations
        }
        saveData()
    }

    func saveData()
    {
        do
        {
            try dataController!.managedObjectContext!.save()
        }
        catch
        {
            fatalError("Failure to save context: \(error)")
        }
    }
}
