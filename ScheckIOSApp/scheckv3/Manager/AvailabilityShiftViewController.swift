//
//  AvailabilityShiftViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/25/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class AvailabilityShiftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dayVar : Int = 0
    var shiftVar : String = ""
    var dayItems = [Days]()
    var id : String = ""
    
    @IBOutlet var logTableView: UITableView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Days")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "(day = %@)", tableArray[dayVar])
        
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Days] {
            dayItems = fetchResults
        }
        println("AvailabilityShifViewController.log : DayItems size = " + dayItems.count.description)
        println("AvailabilityShifViewController.log : DayItems first item is = " + dayItems[0].name)
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }

    func saveNewItem(id : String, day : String, shift : String) {
        // Create the new  log item
        var newLogItem = ShiftAvailability.createInManagedObjectContext(self.managedObjectContext!, id : id, day : day, shift : shift)
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        //if let newItemIndex = find(dayItems, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            //let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            //logTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
        save()
        
        
    }
    
    func addNewItem(id : String, day : String, shift : String) {
        
        var availabilityPrompt = UIAlertController(title: "Confirm Availability", message:"", preferredStyle: .Alert)
        
        var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in self.saveNewItem(id, day : day, shift : shift)
            var localNotification:UILocalNotification = UILocalNotification()
 
            localNotification.alertAction = "An employee indicated availability"
            
            localNotification.alertBody = "One available employee for shift : " + shift
            
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            println("Notification scheduled")
        }
        
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        availabilityPrompt.addAction(okAction)
        availabilityPrompt.addAction(cancelAction)
        
        self.presentViewController(availabilityPrompt, animated: true, completion: nil)
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    fetchLog()


    return dayItems.count
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         //shiftVar = dayItems[indexPath.row].name
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        addNewItem(self.id, day: tableArray[dayVar], shift: dayItems[indexPath.row].name)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLog()
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        fetchLog()


        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "shiftIdentifier")
        
    
    let cell = logTableView.dequeueReusableCellWithIdentifier("availabilityIdentifier") as! UITableViewCell
        cell.textLabel?.text = dayItems[indexPath.row].name
        cell.detailTextLabel?.text = dayItems[indexPath.row].startTime + "-" + dayItems[indexPath.row].endTime
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
