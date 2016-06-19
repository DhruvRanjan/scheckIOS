//
//  ViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 2/26/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mailItems = [Employees]()
    var emailIDs = [String]()
    var names = [String]()
    var emailVar : String = "Hey"
    var mEmail : String = ""
    var companyID : String = ""
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var emailTable: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        fetchLog()
        var i = 0
        var count = 0
        while (i < mailItems.count) {
            if (mailItems[i].email.isEmpty) {
            }
            else {
                emailIDs.insert(mailItems[i].email, atIndex: count)
                names.insert(mailItems[i].name, atIndex: count)
               count = count + 1
            }
            i = i+1
        }
        var s = emailTable.frame.size
        s.height = CGFloat(count) * 44.0
        emailTable.frame.size = s
        emailTable.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        
        return count
    }
    // TODO: Fix companyID for employees
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        // let pred = NSPredicate(format: "(day = %@)", tableArray[dayVar])
        fetchRequest.sortDescriptors=[sortDescriptor]
        let pred2 = NSPredicate(format: "(managerEmail = %@)", mEmail)
//        let pred = NSPredicate(format: "(companyID = %@)", companyID)
//        let compPredicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [pred,pred2])
        //fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = pred2
        // fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
            mailItems = fetchResults
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let kCellIdentifier: String = "name"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = "Email ID : " + emailIDs[indexPath.row]

        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("email is " + emailVar)
        let destination = segue.destinationViewController as! EmailViewController
        destination.emailVar = emailVar
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let text = cell?.textLabel?.text!
        println("text is ", text!)
        emailVar = text!
        performSegueWithIdentifier("sendEmail", sender: self)
        //var alert: UIAlertView = UIAlertView()
        //alert.title = "A"
        //alert.message = "B"
        //alert.addButtonWithTitle("Ok")
        //alert.show()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        fetchLog()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}