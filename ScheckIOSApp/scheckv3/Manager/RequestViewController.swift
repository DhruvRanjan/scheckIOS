//
//  RequestViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/15/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class RequestViewController: UIViewController {

    var reqDay : String = ""
    var reqShiftName : String = ""
    var managerEmail : String = ""
    var requestItems = [Requests]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Requests")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        //let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "request = true")
        let pred2 = NSPredicate(format: "(managerEmail = %@)", managerEmail)
        let compPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred,pred2])
        //fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = compPredicate
        fetchRequest.sortDescriptors=[sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Requests] {
            requestItems = fetchResults
        }
    }
    @IBOutlet var RequestTableView: UITableView!
    
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    func saveNewItem(id : String, name : String, shiftname : String, day : String, startTime : String, endTime : String, request : Bool, availability : Bool, confirmed : Bool) {
        // Create the new  log item
        var newLogItem = Requests.createInManagedObjectContext(self.managedObjectContext!, id : id, name : name, shiftName : shiftname, day : day, startTime : startTime, endTime : endTime, request : request, availability : availability, confirmed : confirmed, managerEmail : managerEmail)
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(requestItems, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            RequestTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        reqDay = requestItems[indexPath.row].day
        reqShiftName = requestItems[indexPath.row].shiftName

        performSegueWithIdentifier("requestSegueIdentifier", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! RequestEditViewController
        destination.reqDay = reqDay
        destination.reqShiftName = reqShiftName
        destination.managerEmail = managerEmail
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestItems.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLog()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var s = RequstTableView.frame.size
        //s.height = min(CGFloat(dayItems.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        //logTableView.frame.size = s
        RequestTableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "shiftIdentifier")
        let cell = RequestTableView.dequeueReusableCellWithIdentifier("requestIdentifier")as! UITableViewCell
        cell.textLabel?.text = requestItems[indexPath.row].name
        cell.detailTextLabel?.text = requestItems[indexPath.row].day + "," + requestItems[indexPath.row].shiftName
        return cell
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
