//
//  RequestEditViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/15/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class RequestEditViewController: UIViewController {
    var managerEmail : String = ""
    var reqDay : String = ""
    var reqShiftName : String = ""
    var requestItems = [Requests]()
    var currentRequestIndex : Int = 0
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var requestTable: UITableView!
    @IBOutlet var denyButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var acceptButton: UIButton!
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Requests")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        //let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "(day = %@)", reqDay)
        let pred2 = NSPredicate(format: "(shiftName = %@)", reqShiftName)
        let pred3 = NSPredicate(format: "availability = true")
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred,pred2,pred3])
        fetchRequest.sortDescriptors=[sortDescriptor]
        //fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Requests] {
            requestItems = fetchResults
        }
    }
    
    func denyRequest() {
       
       let itemToDelete = requestItems[currentRequestIndex]
        managedObjectContext?.deleteObject(itemToDelete)
        self.fetchLog()
        requestTable.deleteRowsAtIndexPaths([currentRequestIndex], withRowAnimation: .Automatic)
        save()
        
    }
    
    func acceptRequest() {
        
        let currentItem = requestItems[currentRequestIndex]
        denyRequest()
        saveNewItem(currentItem.id,name: currentItem.name,shiftname: currentItem.shiftName,day: currentItem.day,startTime: currentItem.startTime,endTime: currentItem.endTime,request: false,availability: false,confirmed: true)
        
    }
    
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
            requestTable.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentRequestIndex = indexPath.row
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestItems.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var s = RequstTableView.frame.size
        //s.height = min(CGFloat(dayItems.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        //logTableView.frame.size = s
        requestTable.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "shiftIdentifier")
        let cell = requestTable.dequeueReusableCellWithIdentifier("requestIdentifier") as! UITableViewCell
        cell.textLabel?.text = requestItems[indexPath.row].name
        //cell.detailTextLabel?.text = requestItems[indexPath.row].day + "," + requestItems[indexPath.row].shiftName
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLog()
        denyButton.addTarget(self, action: "denyRequest", forControlEvents: .TouchUpInside)
        acceptButton.addTarget(self, action: "acceptRequest", forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
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
