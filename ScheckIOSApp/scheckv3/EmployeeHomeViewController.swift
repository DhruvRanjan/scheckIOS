//
//  EmployeeHomeViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/30/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class EmployeeHomeViewController: UITableViewController {

    var name : String = ""
    var id : String = ""
    var email : String = ""
    var password : String = ""
    override func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
    return 3
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var kCellIdentifier: String
        let identifiers = ["Schedule", "Make Requests", "My Info"]
        
        
        kCellIdentifier = identifiers[indexPath.row]
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        cell.textLabel?.text = kCellIdentifier
//        cell.imageView?.image = UIImage(named: (kCellIdentifier + ".jpg"))
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 255.0/255.0 , green: 140.0/255.0, blue: 0.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "viewRequests") {
            let destination = segue.destinationViewController as! EmployeeViewCalendar
            destination.id = self.id
            
        }
        else {
        let destination = segue.destinationViewController as! EmployeeMyInfoViewController
        destination.name = self.name
        destination.email = self.email
        destination.id = self.id
        destination.password = self.password
            
        }
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
