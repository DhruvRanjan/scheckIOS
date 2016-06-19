//
//  ShiftDayControllerTableViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/18/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class ShiftDayControllerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dayVar : Int = 0
    var shiftVar : String = ""
    var managerEmail : String = ""
    var dayItems = [Days]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Create the table view as soon as this class loads
    @IBOutlet var logTableView: UITableView!
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Days")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "(day = %@)", tableArray[dayVar])
        let pred2 = NSPredicate(format: "(managerEmail = %@)", managerEmail)
        let compPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred,pred2])
        //fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = compPredicate
        fetchRequest.sortDescriptors=[sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Days] {
            dayItems = fetchResults
        }
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    let addItemAlertViewTag = 0
    let addItemTextAlertViewTag = 1
    func addNewItem() {
        var s = logTableView.frame.size
        s.height = min(CGFloat(dayItems.count+1) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        logTableView.frame.size = s
        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        var titlePrompt = UIAlertController(title: "Enter Shift",
            message: "",
            preferredStyle: .Alert)
        
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Title"
        }
        
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            textField.placeholder = "Type"
        }
        
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.saveNewItem("name", day: "day",startTime: "st",endTime: "et")
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func saveNewItem(name : String, day : String, startTime : String, endTime : String) {
        // Create the new  log item
        var newLogItem = Days.createInManagedObjectContext(self.managedObjectContext!, name : name, day : day, startTime : startTime, endTime : endTime, managerEmail : managerEmail)
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(dayItems, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            logTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
        
    }
    
    func segue1() {
        performSegueWithIdentifier("addShiftIdentifier", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        var s = logTableView.frame.size
        s.height = min(CGFloat(dayItems.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        logTableView.frame.size = s
        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
        
        // Use optional binding to confirm the managedObjectContext
        if let moc = self.managedObjectContext {
            
            // Create some dummy data to work with
            //var items = [("placeholder","1")
            //("1", "A"),
            //("2","B"),
            //("3","C"),
            //("4","D")
            //]
            //var items = []
            //Loop through, creating items
            //for (itemTitle, itemText) in items {
            // Create an individual item
            //   LogItem.createInManagedObjectContext(moc,
            //       title: itemTitle, text: itemText)
            fetchLog()
            //}
            
            
            // Now that the view loaded, we have a frame for the view, which will be (0,0,screen width, screen height)
            // This is a good size for the table view as well, so let's use that
            // The only adjust we'll make is to move it down by 20 pixels, and reduce the size by 20 pixels
            // in order to account for the status bar
            
            // Store the full frame in a temporary variable
            var viewFrame = self.view.frame
            
            // Adjust it down by 20 points
            viewFrame.origin.y += 20
            
            // Reduce the total height by 20 points
            
            let addButton = UIButton(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width,44))
            addButton.setTitle("+", forState: .Normal)
            addButton.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
            addButton.addTarget(self, action: "segue1", forControlEvents: .TouchUpInside)
            self.view.addSubview(addButton)
            
            //addButton.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
            
            //           addButton.addTarget(self, action: "addNewItem", forControlEvents: .TouchUpInside)
            self.view.addSubview(addButton)
            viewFrame.size.height -= (20 + addButton.frame.size.height)
            
            // Set the logTableview's frame to equal our temporary variable with the full size of the view
            // adjusted to account for the status bar height
            logTableView.frame = viewFrame
            
            // Add the table view to this view controller's view
            self.view.addSubview(logTableView)
            
            
            // This tells the table view that it should get it's data from this class, ViewController
            logTableView.dataSource = self
            
        }
    }
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        fetchLog()
        self.logTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayItems.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let logItemToDelete = dayItems[indexPath.row]
            
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
        println("things")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("other things")
        if segue.identifier == "AvailableSegueIdentifier" {
            let destination = segue.destinationViewController as! ShiftAvailabilityViewController
            destination.dayVar = dayVar
            destination.shiftVar = shiftVar
        }
        else {
            let destination = segue.destinationViewController as! AddShiftViewController
            destination.dayVar = dayVar
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("lllll")
        var s = logTableView.frame.size
        s.height = min(CGFloat(dayItems.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        logTableView.frame.size = s
        logTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "shiftIdentifier")
        let cell = logTableView.dequeueReusableCellWithIdentifier("shiftIdentifier") as! UITableViewCell
        cell.textLabel?.text = dayItems[indexPath.row].name
        cell.detailTextLabel?.text = dayItems[indexPath.row].startTime + "-" + dayItems[indexPath.row].endTime
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
