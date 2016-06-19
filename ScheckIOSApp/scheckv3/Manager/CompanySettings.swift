//
//  CompanySettings.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 6/29/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import Foundation
import CoreData

class CompanySettings: NSManagedObject {

    @NSManaged var companyID: String
    @NSManaged var companyName: String
    @NSManaged var fullTime: String
    @NSManaged var partTime: String
    @NSManaged var companyEmail: String
    @NSManaged var password: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, companyID: String, companyName: String, fullTime: String, partTime : String, companyEmail : String, password : String) -> CompanySettings {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("CompanySettings", inManagedObjectContext: moc) as! CompanySettings
        newItem.companyID = companyID
        newItem.companyName = companyName
        newItem.fullTime = fullTime
        newItem.partTime = partTime
        newItem.companyEmail = companyEmail
        newItem.password = password
        return newItem
    }

}
