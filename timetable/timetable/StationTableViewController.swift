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

class StationTableViewController : UIViewController,
                                    UITableViewDataSource,
                                    UITableViewDelegate,
                                    UISearchResultsUpdating,
                                    NSFetchedResultsControllerDelegate
{
    let stattionCellId = "StationCell"
    
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var fetchedResultsController: NSFetchedResultsController<City>!
    var dataController:DataController?
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }
    
    func setup()
    {
        dataController = DataController.sharedInstance
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: stattionCellId)
        setupSearchController()
        setupFetchedResultsController()
        fetchData()
    }
    
    func setupSearchController()
    {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func setupFetchedResultsController()
    {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataController!.managedObjectContext!,
                                                      sectionNameKeyPath: nil,
                                                               cacheName: nil)
        fetchedResultsController.delegate = self
    }
    
    
    public func updateSearchResults(for searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text!
        let searchPredicate = NSPredicate.init(format:"message CONTAINS[c] %@", searchText)
    }

    func fetchData()
    {
        do
        {
            try self.fetchedResultsController.performFetch()
        }
        catch
        {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.fetchedResultsController.fetchedObjects!.count
    }
    
    public func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        let cities = self.fetchedResultsController.fetchedObjects!
        let stations = Array(cities[section].stations!)
        
        return stations.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: stattionCellId) as UITableViewCell!
        let cities = self.fetchedResultsController.fetchedObjects!
        let stations = Array(cities[indexPath.section].stations!)
        let station = stations[indexPath.row] as! Station
        cell!.textLabel!.text = station.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let cities = self.fetchedResultsController.fetchedObjects!
        
        return cities[section].name;
    }
}
