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
    internal func doSomethingWithData(data: String)
    {
        departure.text = data
    }

    @IBOutlet var departure: UILabel!
    @IBOutlet var destination: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? StationTableViewController {
            destinationViewController.delegate = self
        }
    }

}
