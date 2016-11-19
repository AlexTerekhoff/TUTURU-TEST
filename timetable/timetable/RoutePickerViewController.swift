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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? StationTableViewController {
            destinationViewController.delegate = self
        }
    }

}
