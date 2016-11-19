//
//  StationInfoViewController.swift
//  timetable
//
//  Created by Alexander on 05/11/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import  UIKit

class StationInfoViewController : UIViewController
{
    var station:Station?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        name.text = station!.name
    }
    
}
