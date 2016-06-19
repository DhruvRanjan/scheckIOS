//
//  EmployeesEmailTableViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/17/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class EmployeesEmailTableViewController: UITableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("name", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "Kunal"
        
        // Configure the cell...

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
    }

}
