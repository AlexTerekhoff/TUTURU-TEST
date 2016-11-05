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
    var fetchedResultsController: NSFetchedResultsController<Station>!
    var dataController:DataController?
 
    override func viewDidLoad()
    {
        dataController = DataController.sharedInstance
        setupFetchedResultsController()
        fetchData()
        super.viewDidLoad()
        setup()
    }
    
    func setup()
    {
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
    
    func setupFetchedResultsController()
    {
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataController!.managedObjectContext!,
                                                      sectionNameKeyPath:#keyPath(Station.city.name),
                                                               cacheName: nil)
        fetchedResultsController.delegate = self
    }
    
    public func updateSearchResults(for searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text!
        if searchController.isActive && searchText != ""
        {
            let searchPredicate = NSPredicate.init(format:"name contains[c] %@", searchText)
            fetchedResultsController.fetchRequest.predicate = searchPredicate
 
        }
        else
        {
            fetchedResultsController.fetchRequest.predicate = nil
        }
        fetchData()
        tableView.reloadData()
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
        return self.fetchedResultsController.sections!.count
    }
    
    public func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: stattionCellId) as UITableViewCell!
        let stations = self.fetchedResultsController.sections![indexPath.section].objects as! [Station]
        let station = stations[indexPath.row]
        cell!.textLabel!.text = station.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let main = self.storyboard!.instantiateViewController(withIdentifier: "main")
        navigationController?.pushViewController(main, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return self.fetchedResultsController.sections![section].name
    }
}
