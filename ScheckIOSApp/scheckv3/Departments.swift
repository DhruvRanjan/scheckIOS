//
//  Departments.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/19/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class Departments: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var managerEmail : String
    @NSManaged var companyId : String
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, companyID : String, managerEmail : String) -> Departments {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Departments", inManagedObjectContext: moc) as! Departments
        newItem.name = name
        newItem.companyId = companyID
        newItem.managerEmail = managerEmail
        return newItem
    }
    
}
