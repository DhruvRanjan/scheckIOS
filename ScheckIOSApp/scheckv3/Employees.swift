//
//  Employees.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/18/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class Employees: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var relationship: NSManagedObject
    @NSManaged var department: String
    @NSManaged var hours : String
    @NSManaged var managerEmail : String
    class func createInManagedObjectContext(moc: NSManagedObjectContext, id: String, email: String, name: String, department: String, password: String, hours: String, managerEmail: String) -> Employees {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Employees", inManagedObjectContext: moc) as! Employees
        newItem.id = id
        newItem.email = email
        newItem.name = name
        newItem.password = password
        newItem.department = department
        newItem.hours = hours
        newItem.managerEmail = managerEmail
        return newItem
    }
}
