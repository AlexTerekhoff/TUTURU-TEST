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
    @IBOutlet var tableView: UITableView!
    
    let stattionCellId = "StationCell"
    let searchController = UISearchController(searchResultsController: nil)
    
    var dataController:DataController?
    var filteredCities = [City]()
    var cities = Array<City>.init()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }
    
    func setup()
    {
        dataController = DataController.sharedInstance
        cities = fetchCities()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: stattionCellId)
        setupSearchController()
    }
    
    func setupSearchController()
    {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    public func updateSearchResults(for searchController: UISearchController)
    {
        //         let searchText = searchController.searchBar.text!
        //         let searchPredicate = NSPredicate.init(format:"message CONTAINS[c] %@", searchText)
        //
        //         let filteredStations = self.cities.filter { searchPredicate.evaluate(with:($0))} as! Array<City>
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
        
        cell!.textLabel!.text = city.value(forKey:"name") as? String;
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Section \(section)";
    }
}
