//
//  DepartmentViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/19/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class DepartmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var departmentItems = [Departments]()
    var employeeItems = [Employees]()
    var depVar : String = ""
    var companyID : String = ""
    var mEmail : String = ""
    let managedObjectContext=(UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Departments")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        //fetchRequest.sortDescriptors=[sortDescriptor]
        let pred2 = NSPredicate(format: "(managerEmail = %@)", mEmail)
        let pred = NSPredicate(format: "(companyId = %@)", companyID)
        let compPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred,pred2])
        //fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = compPredicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Departments] {
            
            departmentItems = fetchResults
            
        }
    }
    
    func fetchLog2() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let pred2 = NSPredicate(format: "(managerEmail = %@)", mEmail)
        fetchRequest.predicate = pred2
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
            
            employeeItems = fetchResults
            
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
    
    func addNewItem() {
        
        var titlePrompt = UIAlertController(title: "Enter Department Name",
            message: "",
            preferredStyle: .Alert)
        
        var titlePrompt2 = UIAlertController(title: "Department name cannot be empty",
            message: "",
            preferredStyle: .Alert)
        
        titlePrompt2.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                self.presentViewController(titlePrompt,
                    animated: true,
                    completion: nil)
        }))
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Name"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    if (textField.text.caseInsensitiveCompare("All") == NSComparisonResult.OrderedSame) {
                    }
                    else if (textField.text.isEmpty) {
                        self.presentViewController(titlePrompt2, animated: true, completion: nil)
                    }
                    else {
                        
                        if self.checkForDuplicateDepartments(titleTextField!.text) == true {
                            self.saveNewItem(titleTextField!.text)
                        }
                        else {
                            var alert = UIAlertController(title: "This department already exists", message: "", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }                    }}
                self.departmentTable.reloadData()
        }))
        titlePrompt.addAction(UIAlertAction(title: "Cancel",
            style: .Default,
            handler: { (action) -> Void in
                
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
        
        
    }
    func checkForDuplicateDepartments(department : String) -> Bool {
        for i in departmentItems {
            if i.name == department {
                return false
            }
        }
        return true
    }

    @IBOutlet var departmentTable: UITableView!
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        fetchLog()
        self.departmentTable.reloadData()
    }
    
    func saveNewItem(title : String) {
        // Create the new  log item
        var newLogItem = Departments.createInManagedObjectContext(self.managedObjectContext!, name: title, companyID : self.companyID, managerEmail : self.mEmail)
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
//        if let newItemIndex = find(departmentItems, newLogItem) {
//            // Create an NSIndexPath from the newItemIndex
//            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
//            departmentTable.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
//            save()
//        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {

        fetchLog()
        if (departmentItems.count>0) {

            return (departmentItems.count)
        }
        else {
            saveNewItem("All")
            fetchLog()
 
            departmentTable.reloadData()
            return departmentItems.count
        }  

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(departmentItems.count > 0) {
            var s = tableView.frame.size
            s.height = min(CGFloat(departmentItems.count + 1) * 44.0, UIScreen.mainScreen().bounds.size.height - 105 )
            tableView.frame.size = s
        }
        else {
            var s = tableView.frame.size
            s.height = min(CGFloat(departmentItems.count) * 44.0, UIScreen.mainScreen().bounds.size.height - 105 )
            tableView.frame.size = s
        }
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("departmentCell") as! UITableViewCell
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        self.fetchLog()
        if(indexPath.row<departmentItems.count) {
            cell.textLabel?.text = departmentItems[indexPath.row].name
            println(indexPath.row)
//            println("Number of departments = ", departmentItems.count)
        }
        else {
            cell.textLabel?.text = "All"
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == .Delete ) {
            fetchLog()
            
            
            
            // Find the LogItem object the user is trying to delete
           
            let logItemToDelete = departmentItems[indexPath.row]
            if (logItemToDelete.name.caseInsensitiveCompare("All") == NSComparisonResult.OrderedSame) {
                var titlePrompt = UIAlertController(title: "You cannot delete the selected department",
                    message: "",
                    preferredStyle: .Alert)
                titlePrompt.addAction(UIAlertAction(title: "Ok",
                    style: .Default,
                    handler: { (action) -> Void in
                                        }))
                
                self.presentViewController(titlePrompt,
                    animated: true,
                    completion: nil)
                return
            }
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(logItemToDelete)
            
            // Refresh the table view to indicate that it's deleted
            self.fetchLog()
            
            // Tell the table view to animate out that row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
            }
        departmentTable.reloadData()
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! ViewEmployeesViewController
        destination.depVar = self.depVar
        destination.mEmail = self.mEmail
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
        departmentTable.reloadData()
        if (departmentItems.count == indexPath.row) {
            depVar = "All"
        }
        else {
        depVar = departmentItems[indexPath.row].name
        }
        performSegueWithIdentifier("departmentIdentifier", sender: self)
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
        var s = departmentTable.frame.size
        s.height = min(CGFloat(departmentItems.count) * 44.0 , UIScreen.mainScreen().bounds.size.height - 105 )
        departmentTable.frame.size = s
        departmentTable.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        fetchLog()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        let addButton = UIButton(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width,44))
        addButton.setTitle("+", forState: .Normal)
        addButton.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
        addButton.addTarget(self, action: "addNewItem", forControlEvents: .TouchUpInside)
        self.view.addSubview(addButton)
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
