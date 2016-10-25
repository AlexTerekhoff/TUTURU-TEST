// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.swift instead.

import Foundation
import CoreData

public enum CityAttributes: String {
    case countryTitle = "countryTitle"
}

open class _City: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "City"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _City.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var countryTitle: String

    // MARK: - Relationships

}

