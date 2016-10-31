//
//  Station+CoreDataProperties.swift
//  timetable
//
//  Created by Alexander on 31/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData
import timetable

extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station");
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var city: City?

}
