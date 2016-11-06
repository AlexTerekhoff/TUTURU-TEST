//
//  AppDelegate.swift
//  timetable
//
//  Created by Alexander on 24/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let dataExtractor = DataExtractor()
        //dataExtractor.uploadDataFromJSONDataStore()
        return true
    }

}
