//
//  CalendarClass.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/18/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class CalendarClass: UITableViewController {
    
//    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var dayVar1 : Int = 0
    var managerEmail : String = ""
    override func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var kCellIdentifier: String
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        //let kCellIdentifier: String = "SearchResultCell"
        //let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        //var image : UIImage
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row]) as! UITableViewCell
        cell.textLabel?.text = tableArray[indexPath.row]
        
        //cell.imageView?.image = UIImage(named: tableArray[indexPath.row] + ".png")
        //switch indexPath.row {
        //case 0:
        //    cell.textLabel?.text = "Calendar"
        //    cell.imageView?.image = UIImage(named: "calendar.png")
        //case 1:
        //    cell.textLabel?.text = "E-Mail"
        //    cell.imageView?.image = UIImage(named: "email.png")
        //case 2:
        //    cell.textLabel?.text = "Requests"
        //    cell.imageView?.image = UIImage(named: "requests.png")
        //case 3:
        //    cell.textLabel?.text = "Employees"
        //    cell.imageView?.image = UIImage(named: "employees.png")
        //case 4:
        //    cell.textLabel?.text = "Settings"
        //    cell.imageView?.image = UIImage(named: "settings.png")
        //default:
        //    cell.textLabel?.text = "Error"
        //    cell.imageView?.image = UIImage(named: "ic1.png")
        // }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       let destination = segue.destinationViewController as! ShiftDayControllerTableViewController
       destination.dayVar = dayVar1
       destination.managerEmail = self.managerEmail
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var dayValue : Int
//        switch indexPath.row {
//        case 0: dayValue = "Monday"
//        case 1: dayValue = "Tuesday"
//        case 2: dayValue = "Wednesday"
//        case 3: dayValue = "Thursday"
//        case 4: dayValue = "Friday"
//        case 5: dayValue = "Saturday"
//        case 6: dayValue = "Sunday"
//        default: dayValue = "aaaa"
        //}
        //dayVar1 = dayValue
        dayVar1 = indexPath.row

        performSegueWithIdentifier("dayIdentifier", sender: self)
        //let destination = ShiftDayControllerTableViewController()
        //destination.dayVar = dayVar1
        // prepareForSegue(segue: "daySegue",sender: self)
        //switch indexPath.row {
        //case 0:
            
        
        //var alert: UIAlertView = UIAlertView()
        //alert.title = "A"
        //alert.message = "B"
        //alert.addButtonWithTitle("Ok")
        //alert.show()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        
        //if let moc = managedObjectContext {
        //    var items = [
        //        ("Shift 1", "A"),
        //        ("Shift 2", "B"),
        //        ("Shift 3", "C"),
        //        ("Shift 4", "D")]
        //    for (itemTitle,itemText) in items {
        //        LogItem.createInManagedObjectContext(moc, title: itemTitle, text: itemText)
        //    }
       // }
        //let newItem = NSEntityDescription.insertNewObjectForEntityForName("LogItem", inManagedObjectContext: self.managedObjectContext!) as LogItem
        //newItem.title = "!!!"
        //newItem.itemText = "This is a string from a database"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //override func viewDidAppear(animated: Bool) {
    //    super.viewDidAppear(animated)
    //    let fetchRequest = NSFetchRequest(entityName: "LogItem")
    //    if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [LogItem] {
    //        let alert = UIAlertController(title: fetchResults[0].title,
    //            message: fetchResults[0].itemText,
    //            preferredStyle: .Alert)
    //        self.presentViewController(alert,
    //            animated: true,
    //            completion: nil)
    //    }
    
    // }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    
    
   
}
