//
//  City+CoreDataProperties.swift
//  timetable
//
//  Created by Alexander on 28/10/2016.
//  Copyright © 2016 Alexander Terekhov. All rights reserved.
//

import Foundation
import CoreData

extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var countryTitle: String?
    @NSManaged public var districtTitle: String?
    @NSManaged public var cityId: Int64
    @NSManaged public var cityTitle: String?
    @NSManaged public var regionTitle: String?
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
