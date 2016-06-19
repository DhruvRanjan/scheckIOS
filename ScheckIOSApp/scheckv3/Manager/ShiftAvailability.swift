//
//  ShiftAvailability.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/14/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class ShiftAvailability: NSManagedObject {

    @NSManaged var day: String
    @NSManaged var id: String
    @NSManaged var shift: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, id: String, day: String, shift: String) -> ShiftAvailability {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("ShiftAvailability", inManagedObjectContext: moc) as! ShiftAvailability
        newItem.id = id
        newItem.day = day
        newItem.shift = shift
        return newItem
    }

}
