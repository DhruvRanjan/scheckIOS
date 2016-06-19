//
//  ViewEmployeesViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/18/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class ViewEmployeesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var employees = [Employees]()
    var depVar : String = ""
    var mEmail : String = ""
    let managedObjectContext=(UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors=[sortDescriptor]
        if (depVar.caseInsensitiveCompare("All") == NSComparisonResult.OrderedSame ) {
            let pred2 = NSPredicate(format: "(managerEmail = %@)", mEmail)
            fetchRequest.predicate = pred2
        }
        else {
            let pred = NSPredicate(format: "(department = %@)", depVar)
            let pred2 = NSPredicate(format: "(managerEmail = %@)", mEmail)
            let compPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred,pred2])
            //fetchRequest.sortDescriptors=[sortDescriptor]
            fetchRequest.predicate = compPredicate
        }
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
            
            employees = fetchResults
            
        }
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            //            println(error?.localizedDescription)
        }
    }
    
    //    func updateNewItem(id: String, email : String, name : String) {
    //        // Create the new  log item
    //        if employees.count != 0 {
    //            managedObjectContext?.deleteObject(employees[0])
    //        }
    //        var newLogItem = Employees.createInManagedObjectContext(self.managedObjectContext!, id: id, email: email, name: name)
    //        // Update the array containing the table view row data
    //        self.fetchLog()
    //
    //        save()
    //    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //        emailAddress.text = ""
        fetchLog()
        //        if (employees.count > 0) {
        //            emailAddress.text = employees[employees.count-1].email
        //        }
        //        else {
        //            emailAddress.text = "example@scheck.com"
        //        }
    }
    
//    func addNewItem() {
//        
//        var titlePrompt = UIAlertController(title: "Enter id",
//            message: "",
//            preferredStyle: .Alert)
//        var titlePrompt2 = UIAlertController(title: "ID cannot be empty",
//            message: "",
//            preferredStyle: .Alert)
//        
//        titlePrompt2.addAction(UIAlertAction(title: "Ok",
//            style: .Default,
//            handler: { (action) -> Void in
//                self.presentViewController(titlePrompt,
//                    animated: true,
//                    completion: nil)
//        }))
//        var titleTextField: UITextField?
//        titlePrompt.addTextFieldWithConfigurationHandler {
//            (textField) -> Void in
//            titleTextField = textField
//            textField.placeholder = "ID"
//        }
//        
//        titlePrompt.addAction(UIAlertAction(title: "Ok",
//            style: .Default,
//            handler: { (action) -> Void in
//                
//                if let textField = titleTextField {
//                    if (textField.text.isEmpty) {
//                        self.presentViewController(titlePrompt2,
//                            animated: true,
//                            completion: nil)
//                    }
//                    else {
//                        self.saveNewItem(textField.text)
//                    }
//                }
//        }))
//        titlePrompt.addAction(UIAlertAction(title: "Cancel",
//            style: .Default,
//            handler: { (action) -> Void in
//                
//        }))
//        self.presentViewController(titlePrompt,
//            animated: true,
//            completion: nil)
//        
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! AddEmployeeViewController
        destination.depVar = self.depVar
        destination.mEmail = self.mEmail
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        fetchLog()
        self.tableView.reloadData()
    }
//    func saveNewItem(title : String) {
//        // Create the new  log item
//        var newLogItem = Employees.createInManagedObjectContext(self.managedObjectContext!, id :title, email :"", name : "", department: depVar, password : "")
//        
//        // Update the array containing the table view row data
//        self.fetchLog()
//        
//        // Animate in the new row
//        // Use Swift's find() function to figure out the index of the newLogItem
//        // after it's been added and sorted in our logItems array
//        if let newItemIndex = find(employees, newLogItem) {
//            // Create an NSIndexPath from the newItemIndex
//            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
//            tableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
//            save()
//        }
    
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        var s = tableView.frame.size
        s.height = min(CGFloat(employees.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105)
        tableView.frame.size = s
        fetchLog()
        return employees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var s = tableView.frame.size
        s.height = min(CGFloat(employees.count) * 44.0, UIScreen.mainScreen().bounds.size.height - 105 )
        tableView.frame.size = s
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("employeeName") as! UITableViewCell
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        self.fetchLog()
        
        if (!employees[indexPath.row].name.isEmpty) {
            cell.textLabel?.text = employees[indexPath.row].name
            cell.detailTextLabel?.text = "ID : " + employees[indexPath.row].id
        }
        else {
            cell.detailTextLabel?.text = "ID : " + employees[indexPath.row].id
            cell.textLabel?.text = "Unregistered employee"
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let logItemToDelete = employees[indexPath.row]
            var alert =
            UIAlertController(
                title: "Are you sure you wish to delete this employee?",
                message: "",
                preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: { (action) -> Void in
                    // Delete it from the managedObjectContext
                    self.managedObjectContext?.deleteObject(logItemToDelete)
                    
                    // Refresh the table view to indicate that it's deleted
                    self.fetchLog()
                    
                    // Tell the table view to animate out that row
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    self.save()
                }
                ))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,
                handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            //    // Delete it from the managedObjectContext
            //    managedObjectContext?.deleteObject(logItemToDelete)
            //
            //    // Refresh the table view to indicate that it's deleted
            //    self.fetchLog()
            //
            //    // Tell the table view to animate out that row
            //    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            //    save()
        }
    }
    
    func segue1() {
        performSegueWithIdentifier("departmentIdentifier2", sender: self)
    }
    
    override func viewDidLoad() {
        var s = tableView.frame.size
        s.height = min(CGFloat(employees.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        tableView.frame.size = s
        tableView.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        fetchLog()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        let addButton = UIButton(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width,44))
        addButton.setTitle("+", forState: .Normal)
        addButton.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
        addButton.addTarget(self, action: "segue1", forControlEvents: .TouchUpInside)
        self.view.addSubview(addButton)
        //let addButton = UIButton(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width,44))
        //addButton.setTitle("+", forState: .Normal)
        //addButton.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
        //addButton.addTarget(self, action: "addNewItem", forControlEvents: .TouchUpInside)
        //self.view.addSubview(addButton)
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