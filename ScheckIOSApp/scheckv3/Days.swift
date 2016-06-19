//
//  Days.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/18/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class Days: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var day: String
    @NSManaged var startTime: String
    @NSManaged var endTime: String
    @NSManaged var managerEmail: String
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, day: String, startTime: String, endTime: String, managerEmail: String) -> Days {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Days", inManagedObjectContext: moc) as! Days
        newItem.name = name
        newItem.day = day
        newItem.startTime = startTime
        newItem.endTime = endTime
        newItem.managerEmail = managerEmail
        return newItem
    }

}
