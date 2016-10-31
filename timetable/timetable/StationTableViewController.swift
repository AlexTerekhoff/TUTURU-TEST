//
//  StationTableViewController.swift
//  timetable
//
//  Created by Alexander on 25/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StationTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating
{
    let stattionCellId: String = "StationCell"
    let searchController = UISearchController(searchResultsController: nil)
   
    public func updateSearchResults(for searchController: UISearchController)
    {
         let searchText = searchController.searchBar.text!
         let searchPredicate = NSPredicate.init(format:"message CONTAINS[c] %@", searchText)
        
         let filteredStations = self.cities.filter { searchPredicate.evaluate(with:($0))} as! Array<City>
    }
    
    var filteredCities = [City]()
    var cities = Array<City>.init()
    var dataController:DataController?
    
    
    
    @IBOutlet var tableView: UITableView!
    
    func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    func fetchCities () -> Array<City>
    {
        var cities = Array<City>.init()
        let citiesFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do
        {
            cities = try dataController!.managedObjectContext?.fetch(citiesFetchRequest) as! [City]
        }
        catch
        {
            fatalError("Failed to fetch cities: \(error)")
        }

        return cities
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataController = DataController.init()
        uploadData ()
        cities = fetchCities()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: stattionCellId)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
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
                                                                 into: dataController!.managedObjectContext!)
                entity.setValue(title, forKey: "cityTitle")
                
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
        catch
        {
            fatalError("Error in uploading data");
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        return cities.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: stattionCellId) as
            UITableViewCell!
                                                 
        let city = cities[indexPath.row]
        
        cell!.textLabel!.text = city.value(forKey:"cityTitle") as? String;
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Section \(section)";
    }
}
