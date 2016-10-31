//
//  Point+CoreDataProperties.swift
//  timetable
//
//  Created by Alexander on 31/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData
import timetable

extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point");
    }

    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var city: City?

}
