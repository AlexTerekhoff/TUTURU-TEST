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
        let city = NSEntityDescription.insertNewObject(forEntityName:"City",
                                                       into:managedObjectConext()) as! City
        parseCityData(from:cityDictionary,
                      to:city)
        
        let extractedStations = extractStationsFrom(dictionary:cityDictionary)
        city.stations = extractedStations as NSSet?
    }
    
    func parseCityData(from jsonDictionary :Dictionary<String, AnyObject>,
                       to city:City)
    {
        city.id = jsonDictionary["cityId"]!.int64Value
        city.name = jsonDictionary["cityTitle"] as? String
        city.country = jsonDictionary["countryTitle"] as? String
        city.district = jsonDictionary["districtTitle"] as? String
        city.region = jsonDictionary["regionTitle"] as? String
    }
    
    func extractStationsFrom(dictionary:Dictionary<String, AnyObject>) -> Set<Station>
    {
        var extractedStations = Set<Station>.init()
        let stations = dictionary["stations"] as! Array <Dictionary<String, AnyObject>>
        
        for station in stations
        {
            let entityStation = NSEntityDescription.insertNewObject(forEntityName:"Station",
                                                                    into: managedObjectConext()) as! Station
            parseStationData(from:station,
                             to:entityStation)
            extractedStations.insert(entityStation)
        }
        
        return extractedStations
    }
    
    func parseStationData(from jsonDictionary: Dictionary<String, AnyObject>,
                          to station: Station)
    {
        station.id = jsonDictionary["stationId"]!.int64Value
        station.name = jsonDictionary["stationTitle"] as? String
        //let id = jsonDictionary["stationId"] as! Int64

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
