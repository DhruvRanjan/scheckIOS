//
//  Shifts.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 7/14/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class Shifts: NSManagedObject {

    @NSManaged var day: String
    @NSManaged var id: String
    @NSManaged var shift: String
    @NSManaged var managerEmail: String
    
    @NSManaged var relationship: Employees
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, id: String, day: String, shift: String, managerEmail: String) -> Shifts {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Shifts", inManagedObjectContext: moc) as! Shifts
        newItem.id = id
        newItem.day = day
        newItem.shift = shift
        newItem.managerEmail = managerEmail
        return newItem
    }


}
