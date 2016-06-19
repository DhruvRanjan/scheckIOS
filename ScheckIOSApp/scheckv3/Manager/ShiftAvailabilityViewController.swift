//
//  ShiftAvailabilityViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/14/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class ShiftAvailabilityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dayVar : Int = 0
    var managerEmail : String = ""
    var shiftVar : String = ""
    var shiftItems = [ShiftAvailability]()
    var shiftItems2 = [Shifts]()
    var employeeItems = [Employees]()
    var id : String = ""
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var AvailabilityTableView: UITableView!
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "ShiftAvailability")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred1 = NSPredicate(format: "(day = %@)", tableArray[dayVar])
        let pred2 = NSPredicate(format: "(shift = %@)", shiftVar)
        let pred3 = NSPredicate(format: "(managerEmail = %@)", managerEmail)
        let fpredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred1, pred2, pred3])
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = fpredicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ShiftAvailability] {
            shiftItems = fetchResults
        }
    }
    
    func fetchLog2() {
        let fetchRequest = NSFetchRequest(entityName: "Shifts")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred1 = NSPredicate(format: "(day = %@)", tableArray[dayVar])
        let pred2 = NSPredicate(format: "(shift = %@)", shiftVar)
        let pred3 = NSPredicate(format: "(managerEmail = %@)", managerEmail)
        let fpredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred1, pred2, pred3])
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = fpredicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Shifts] {
            shiftItems2 = fetchResults
        }

    }
    
    func fetchLog3() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let pred3 = NSPredicate(format: "(managerEmail = %@)", managerEmail)
        let fpredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred3])
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees]{
            employeeItems = fetchResults
        }
        
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    func saveNewItem(id : String, day : String, Shift : String) {
        // Create the new  log item
        var newLogItem = ShiftAvailability.createInManagedObjectContext(self.managedObjectContext!, id : id, day : day, shift : Shift)
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(shiftItems, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            AvailabilityTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
        
    }
    
    func saveNewItem2(id : String, day : String, Shift : String) {
        // Create the new  log item
<<<<<<< HEAD
        var newLogItem = Shifts.createInManagedObjectContext(self.managedObjectContext!, id : id, day : day, shift : Shift, managerEmail : managerEmail)
=======
        var newLogItem = Shifts.createInManagedObjectContext(self.managedObjectContext!, id : id, day : day, shift : Shift)
>>>>>>> d7a0f8dddfb5ec8f0d17b13eded7469634eb1085
        
        // Update the array containing the table view row data
        //self.fetchLog2()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(shiftItems2, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            AvailabilityTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
        
    }
    
//    func saveNewItem3(id : String, email: String, name: String, department: String, password: String, hours: String) {
//        var newItem =
//    }
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        fetchLog()
        fetchLog2()
        fetchLog3()
        self.AvailabilityTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("total items: ")
        println(shiftItems.count + shiftItems2.count)
        return shiftItems.count + shiftItems2.count

    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        fetchLog()
        fetchLog2()
        fetchLog3()
        // Do any additional setup after loading the view.
    }
    
    func findHours(id : String) -> String {
        for item in employeeItems {
            if item.id == id {
                return item.hours
            }
        }
        return "hours could not be calculated"
    }
    
    func findName(id : String) -> String {
        for item in employeeItems {
            if item.id == id {
                return item.name
            }
        }
        return "name could not be found"
    }
    
    func addShift() -> Bool {
     
        var alert = UIAlertController(title: "Add Employee to shift?", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: {(action)-> Void in
                return true}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,
            handler: {(action)-> Void in
                return true}))
        self.presentViewController(alert,animated: true, completion: nil)
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row >= shiftItems2.count && addShift() == true {
            saveNewItem2(shiftItems[indexPath.row - shiftItems2.count].id, day: shiftItems[indexPath.row-shiftItems2.count].day, Shift: shiftItems[indexPath.row-shiftItems2.count].shift)
            let itemToDelete = shiftItems[indexPath.row-shiftItems2.count]
            managedObjectContext?.deleteObject(itemToDelete)
            save()
            self.fetchLog()
            self.fetchLog2()
            
            AvailabilityTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        AvailabilityTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "shiftIdentifier")
        let cell = AvailabilityTableView.dequeueReusableCellWithIdentifier("AvailabilityIdentifier") as! UITableViewCell
//        let cell2 = AvailabilityTableView.dequeueReusableCellWithIdentifier("ShiftIdentifier") as! UITableViewCell
        if indexPath.row < shiftItems2.count {
            println("assigned count is: ")
            println(shiftItems2.count)
            // cell.textLabel?.text = shiftItems2[indexPath.row].id
            cell.textLabel?.text = findName(shiftItems2[indexPath.row].id)
            cell.detailTextLabel?.text = findHours(shiftItems2[indexPath.row].id) + " hours"
        
            cell.backgroundColor = UIColor.yellowColor()
        }
        else {
            // cell.textLabel?.text = shiftItems[indexPath.row].id
            println("available count is: ")
            println(shiftItems.count)
            cell.textLabel?.text = findName(shiftItems[indexPath.row - shiftItems2.count].id)
            cell.detailTextLabel?.text = findHours(shiftItems[indexPath.row - shiftItems2.count].id) + " hours"
        }
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
