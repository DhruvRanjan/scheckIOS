//
//  Requests.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/15/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class Requests: NSManagedObject {

    @NSManaged var day: String
    @NSManaged var endTime: String
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var shiftName: String
    @NSManaged var startTime: String
    @NSManaged var request: NSNumber
    @NSManaged var availability: NSNumber
    @NSManaged var confirmed: NSNumber
    @NSManaged var managerEmail: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, id: String, name: String, shiftName: String, day : String, startTime : String, endTime : String, request : NSNumber, availability : NSNumber, confirmed : NSNumber, managerEmail: String) -> Requests {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Requests", inManagedObjectContext: moc) as! Requests
        newItem.id = id
        newItem.name = name
        newItem.shiftName = shiftName
        newItem.day = day
        newItem.startTime = startTime
        newItem.endTime = endTime
        newItem.request = request
        newItem.availability = availability
        newItem.confirmed = confirmed
        newItem.managerEmail = managerEmail
        return newItem
    }

}
    