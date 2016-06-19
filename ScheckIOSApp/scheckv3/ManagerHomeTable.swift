//
//  ManagerHomeTable.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 2/26/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}
class ManagerHomeTable: UITableViewController {
    var delegate: CenterViewControllerDelegate?
    var name : String = ""
    var email : String = ""
    var id : String = ""
    var password : String = ""
    
    @IBAction func sideBarPressed(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
        
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var kCellIdentifier: String = ""
        let identifiers = ["Calendar", "E-Mail", "Requests", "Employees", "Settings"]
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        kCellIdentifier = identifiers[indexPath.row]
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        cell.textLabel?.text = kCellIdentifier
        cell.imageView?.image = UIImage(named: (kCellIdentifier + ".jpg"))
        return cell
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 4) {
            println("Going into settings")
            performSegueWithIdentifier("settingsSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Name sending second time is " + self.name)
        println("Email sending second time is " + self.email)
        println("ID sending second time is " + self.id)
        if(segue.identifier?.caseInsensitiveCompare("settingsSegue") == NSComparisonResult.OrderedSame) {   let destination = segue.destinationViewController as! SettingsTableView
            destination.name = self.name
            destination.id = self.id
            destination.emailC = self.email
            
        }
        if(segue.identifier?.caseInsensitiveCompare("departmentSegue") == NSComparisonResult.OrderedSame) {
            let destination = segue.destinationViewController as! DepartmentViewController
            destination.companyID = self.id
            destination.mEmail = self.email
        }
        if(segue.identifier?.caseInsensitiveCompare("calendarSegue") == NSComparisonResult.OrderedSame) {
            let destination = segue.destinationViewController as! CalendarClass
            destination.managerEmail = self.email
        }
        if(segue.identifier?.caseInsensitiveCompare("emailSegue") == NSComparisonResult.OrderedSame) {
            let destination = segue.destinationViewController as! ViewController
            destination.companyID = self.id
            destination.mEmail = self.email
        }
        if(segue.identifier?.caseInsensitiveCompare("requestSegue") == NSComparisonResult.OrderedSame) {
            let destination = segue.destinationViewController as! RequestViewController
            destination.managerEmail = self.email
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}