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
    
    typealias JSONDataType = Dictionary<String, Array <Dictionary<String, AnyObject>>>
    
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
    
    func uploadDataFromJSONDataStore()
    {
        let url = Bundle.main.url(forResource: "allStations",
                               withExtension: "json")
        do
        {
            let data = try Data.init(contentsOf: url!)
            let jsonDictionary = try JSONSerialization.jsonObject(with: data) as! JSONDataType
            importDataToPersisitentStore(data:jsonDictionary)
        }
        catch
        {
            fatalError("Error in uploading data");
        }
    }
    
    func importDataToPersisitentStore(data:JSONDataType)
    {
        parseCitiesFrom(jsonDictionary:data,
                              cityKey:citiesFromKey)
    }
    
    func parseCitiesFrom(jsonDictionary:JSONDataType,
                                cityKey:String)
    {
        let cities = jsonDictionary[cityKey]
        for city in cities!
        {
            extractCityPropertiesFrom(cityDictionary:city)
        }
        saveData()
    }
    
    func extractCityPropertiesFrom(cityDictionary:Dictionary<String, AnyObject>)
    {
        let entityCity = NSEntityDescription.insertNewObject(forEntityName:"City",
                                                                    into:managedObjectConext())
        parseCityDataFrom(jsonDictionary:cityDictionary,
                               toEntity:entityCity)
        
        let extractedStations = extractStationsFrom(dictionary:cityDictionary)
        entityCity.setValue(extractedStations, forKeyPath: "stations")
    }
    
    func parseCityDataFrom(jsonDictionary:Dictionary<String, AnyObject>,
                                 toEntity:NSManagedObject)
    {
        //let id = jsonDictionary["cityId"] as! Int64
        let name = jsonDictionary["cityTitle"] as! String
        let country = jsonDictionary["cityTitle"] as! String
        let district = jsonDictionary["districtTitle"] as! String
        let region = jsonDictionary["regionTitle"] as! String
        
        //toEntity.setValue(id, forKey:"id")
        toEntity.setValue(name, forKey:"name")
        toEntity.setValue(country, forKey:"district")
        toEntity.setValue(district, forKey:"region")
        toEntity.setValue(region, forKey:"country")
    }
    
    func extractStationsFrom(dictionary:Dictionary<String, AnyObject>) -> Set<Station>
    {
        var extractedStations = Set<Station>.init()
        let stations = dictionary["stations"] as! Array <Dictionary<String, AnyObject>>
        
        for station in stations
        {
            let entityStation = NSEntityDescription.insertNewObject(forEntityName:"Station",
                                                                           into: managedObjectConext())
            parseStationDataFrom(jsonDictionary:station,
                                      toEntity:entityStation)
            extractedStations.insert(entityStation as! Station)
        }
       
        return extractedStations
    }
    
    func parseStationDataFrom(jsonDictionary:Dictionary<String, AnyObject>,
                                    toEntity:NSManagedObject)
    {
        let name = jsonDictionary["stationTitle"] as! String
        //let id = jsonDictionary["stationId"] as! Int64
        
        toEntity.setValue(name, forKeyPath: "name")
        //toEntity.setValue(id, forKeyPath: "id")
    }
    
    func extractPointFrom(dictionary:Dictionary<String, AnyObject>)
    {
//        let entityPoint = NSEntityDescription.insertNewObject(forEntityName:"Point",
//                                                                     into: managedObjectConext())
    }

    func managedObjectConext() -> NSManagedObjectContext
    {
        return dataController!.managedObjectContext!
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
