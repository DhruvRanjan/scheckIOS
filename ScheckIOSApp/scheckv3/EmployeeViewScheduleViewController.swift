//
//  EmployeeViewScheduleViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 7/9/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class EmployeeViewScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dayVar : Int = 0
    var shiftVar : String = ""
    var managerEmail : String = ""
    var dayItems = [Days]()
    var id : String = ""

    var shiftItems = [Shifts]()
    

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    

    @IBOutlet var logTableView: UITableView!
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Shifts")
        let sortDescriptor = NSSortDescriptor(key: "shift", ascending: true)
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred1 = NSPredicate(format: "(day = %@)", tableArray[dayVar])
        let pred2 = NSPredicate(format: "(id = %@)", self.id)
        let fpredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred1, pred2])
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = fpredicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Shifts] {
            shiftItems = fetchResults
        }
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
//    func saveNewItem(name : String, day : String, startTime : String, endTime : String) {
//        // Create the new  log item
//        var newLogItem = Days.createInManagedObjectContext(self.managedObjectContext!, name : name, day : day, startTime : startTime, endTime : endTime)
//        
//        // Update the array containing the table view row data
//        self.fetchLog()
//        
//        // Animate in the new row
//        // Use Swift's find() function to figure out the index of the newLogItem
//        // after it's been added and sorted in our logItems array
//        if let newItemIndex = find(dayItems, newLogItem) {
//            // Create an NSIndexPath from the newItemIndex
//            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
//            // Animate in the insertion of this row
//            logTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
//            save()
//        }
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
//        var s = logTableView.frame.size
//        s.height = min(CGFloat(dayItems.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
//        logTableView.frame.size = s
//        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
    }
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        fetchLog()
        self.logTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shiftItems.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let logItemToDelete = shiftItems[indexPath.row]
            
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(logItemToDelete)
            
            // Refresh the table view to indicate that it's deleted
            self.fetchLog()
            
            // Tell the table view to animate out that row
            logTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        shiftVar = dayItems[indexPath.row].name
        performSegueWithIdentifier("AvailableSegueIdentifier", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AvailableSegueIdentifier" {
            let destination = segue.destinationViewController as! ShiftAvailabilityViewController
            destination.managerEmail = self.managerEmail
            destination.dayVar = dayVar
            destination.shiftVar = shiftVar
            destination.id = self.id
        }
        else {
            let destination = segue.destinationViewController as! AddShiftViewController
            destination.dayVar = dayVar
            destination.managerEmail = self.managerEmail
        }
    }

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        shiftVar = dayItems[indexPath.row].name
//        performSegueWithIdentifier("AvailableSegueIdentifier", sender: self)
//        
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "AvailableSegueIdentifier" {
//            let destination = segue.destinationViewController as! ShiftAvailabilityViewController
//            destination.dayVar = dayVar
//            destination.shiftVar = shiftVar
//        }
//        else {
//            let destination = segue.destinationViewController as! AddShiftViewController
//            destination.dayVar = dayVar
//        }
//    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "shiftIdentifier")
        let cell = logTableView.dequeueReusableCellWithIdentifier("shiftIdentifier") as! UITableViewCell
        cell.textLabel?.text = shiftItems[indexPath.row].shift
        // cell.detailTextLabel?.text = shiftItems[indexPath.row].startTime + "-" + dayItems[indexPath.row].endTime
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
