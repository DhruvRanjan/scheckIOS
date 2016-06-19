//
//  EmployeeViewRequestsViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/25/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class EmployeeViewRequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var requests = [Requests]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var id : String = ""
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Requests")
        //let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        //fetchRequest.sortDescriptors=[sortDescriptor]
        let pred = NSPredicate(format: "(id = %@)", id)
        fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Requests] {
            
            requests = fetchResults
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name = "Shift name: " + requests[indexPath.row].name
        
        var titlePrompt = UIAlertController(title: "Shift name: ",
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
//                if let textField = titleTextField {
//                    
//
//                }
        }))
        
        titlePrompt.addAction(UIAlertAction(title: "Deny",
            style: .Default,
            handler: { (action) -> Void in
//                if let textField = titleTextField {
////                  self.saveNewItem("name", day: "day",startTime: "st",endTime: "et")
//                }
        }))

        titlePrompt.addAction(UIAlertAction(title: "Cancel",
            style: .Default,
            handler: nil    ))

        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            //            println(error?.localizedDescription)
        }
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        fetchLog()
        var s = tableView.frame.size
        s.height = min(CGFloat(requests.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105)
        tableView.frame.size = s
        
        return requests.count
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var s = tableView.frame.size
        s.height = min(CGFloat(requests.count) * 44.0, UIScreen.mainScreen().bounds.size.height - 105 )
        tableView.frame.size = s
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("viewRequests") as! UITableViewCell
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        self.fetchLog()
        
        if (requests[indexPath.row].name != "") {
            cell.textLabel?.text = requests[indexPath.row].name
            cell.detailTextLabel?.text = requests[indexPath.row].day + " " + requests[indexPath.row].startTime + "-" + requests[indexPath.row].endTime
        }
        else {
            cell.textLabel?.text = requests[indexPath.row].id
        }
        
        
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
