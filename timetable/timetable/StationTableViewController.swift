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

class StationTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let stattionCellId: String = "StationCell"
    var cities:Array<City> = Array<City>.init()
    
    @IBOutlet var tableView: UITableView!
    
    var dataController = DataController.init()
    
    func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        cities = fetchCities()
    }
    
    func fetchCities () -> Array<City>
    {
        var cities: Array = Array<City>.init()
        let citiesFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do
        {
            cities = try dataController.managedObjectContext.fetch(citiesFetchRequest) as! [City]
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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: stattionCellId)
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
