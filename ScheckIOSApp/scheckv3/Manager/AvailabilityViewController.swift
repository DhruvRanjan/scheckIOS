//
//  AvailabilityViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/25/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class AvailabilityViewController: UIViewController {

    var id : String = ""
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var dayVar1 : Int = 0
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        return 7
    }
    
    @IBOutlet var logTableView: UITableView!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var kCellIdentifier: String
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row]) as! UITableViewCell
        cell.textLabel?.text = tableArray[indexPath.row]

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination = segue.destinationViewController as! AvailabilityShiftViewController 
        destination.dayVar = dayVar1
        destination.id = self.id
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var dayValue : Int

        dayVar1 = indexPath.row
        
        performSegueWithIdentifier("dayIdentifier", sender: self)
  
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}
