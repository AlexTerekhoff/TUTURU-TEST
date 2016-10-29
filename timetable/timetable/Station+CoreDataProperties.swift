//
//  Station+CoreDataProperties.swift
//  timetable
//
//  Created by Alexander on 29/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station");
    }

    @NSManaged public var stationId: Int64
    @NSManaged public var stationTitle: String?
    @NSManaged public var city: City?

}
