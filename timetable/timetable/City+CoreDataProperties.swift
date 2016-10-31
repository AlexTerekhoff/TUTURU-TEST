//
//  City+CoreDataProperties.swift
//  timetable
//
//  Created by Alexander on 31/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData
import timetable

extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var district: String?
    @NSManaged public var region: String?
    @NSManaged public var point: Point?
    @NSManaged public var stations: NSSet?

}

// MARK: Generated accessors for stations
extension City {

    @objc(addStationsObject:)
    @NSManaged public func addToStations(_ value: Station)

    @objc(removeStationsObject:)
    @NSManaged public func removeFromStations(_ value: Station)

    @objc(addStations:)
    @NSManaged public func addToStations(_ values: NSSet)

    @objc(removeStations:)
    @NSManaged public func removeFromStations(_ values: NSSet)

}
