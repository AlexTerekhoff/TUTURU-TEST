//
//  RoutePickerViewController.swift
//  timetable
//
//  Created by Alexander on 05/11/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import UIKit

class RoutePickerViewController: UIViewController, DestinationViewControllerDelegate
{
    @IBOutlet weak var departure: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var destinationViewController:StationTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationViewController  = self.storyboard?.instantiateViewController(withIdentifier: "StationsTable") as? StationTableViewController
        destinationViewController!.delegate = self
    }
    
    func updateDeparture(station: Station) {
        departure.text = station.name!
    }
    func updateDestination(station: Station) {
        destination.text = station.name!
    }
    
    @IBAction func datePickerAction(_ sender: AnyObject) {
        print(datePicker.date)
    }
    
    @IBAction func presentDepartureStationTableViewController (_ sender: AnyObject) {
        destinationViewController!.isDepartureCity = true
         navigationController!.pushViewController(destinationViewController!, animated: true)
    }
    
    @IBAction func presentDestinationStationTableViewController (_ sender: AnyObject) {
        destinationViewController!.isDepartureCity = false
        navigationController!.pushViewController(destinationViewController!, animated: true)
    }
}
