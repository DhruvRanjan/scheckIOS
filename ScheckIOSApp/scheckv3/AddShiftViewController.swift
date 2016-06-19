//
//  AddShiftViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/18/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData


class AddShiftViewController: UIViewController {
    var startPickerView  : UIDatePicker = UIDatePicker()
    var endPickerView  : UIDatePicker =  UIDatePicker()
    var dayVar : Int = 0
    var managerEmail : String = ""
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBAction func doneButton(sender: AnyObject) {
        let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        var dayString : String = tableArray[dayVar]
        if name.text.isEmpty {
            var alert =
            UIAlertController(
                title: "Warning",
                message: "Please Enter Name",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
         ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if startTime.text.isEmpty {
            var alert =
            UIAlertController(
                title: "Warning",
                message: "Please Enter Start Time",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if endTime.text.isEmpty {
            var alert =
            UIAlertController(
                title: "Warning",
                message: "Please Enter End Time",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            var timeFormatter = NSDateFormatter()
            timeFormatter.dateStyle = .NoStyle
            timeFormatter.timeStyle = .ShortStyle
            var sTime : NSDate! = timeFormatter.dateFromString(startTime.text)
            var eTime : NSDate! = timeFormatter.dateFromString(endTime.text)
            
            var dif  = (eTime.timeIntervalSinceDate(sTime))/3600
            if ( dif < 0 ) {
                var alert =
                UIAlertController(
                    title: "Warning",
                    message: "Shift duration is more than 12 hours",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                    handler: { (action) -> Void in
                        self.saveNewItem(self.name.text, day: dayString, startTime: self.startTime.text,endTime: self.endTime.text)
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                        }
                        //self.performSegueWithIdentifier("minion", sender: nil)
                        
                    }
                    ))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                    
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                self.saveNewItem(self.name.text, day: dayString,startTime: self.startTime.text,endTime: self.endTime.text)
                if let navController = self.navigationController {
                    navController.popViewControllerAnimated(true) }
                //self.performSegueWithIdentifier("minion", sender: nil)
            }
            
        
    
        }
        
    }
    
    @IBOutlet var endTime: UITextField!
    @IBOutlet var startTime: UITextField!
    @IBOutlet var name: UITextField!
    
    @IBAction func sTime1(sender: AnyObject) {
        startTimeEntered(sender as! UITextField)
    }
    @IBAction func startTimeEntered(sender: UITextField) {
        
        startPickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = startPickerView
        startPickerView.backgroundColor = UIColor(red: CGFloat(0.984), green: CGFloat(0.922), blue: CGFloat(0.831), alpha: 1.0)
        startPickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.AllEvents)

    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    func saveNewItem(name : String, day : String, startTime : String, endTime : String) {
        // Create the new  log item
        var newLogItem = Days.createInManagedObjectContext(self.managedObjectContext!, name : name, day : day, startTime : startTime, endTime : endTime, managerEmail : managerEmail)
            save()
    }
    
    @IBAction func stime11(sender: UITextField) {
        startTimeEntered(sender)
        
    }
    
    @IBAction func etim1(sender: UITextField) {
        endTimeEntered(sender)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        startTime.text = timeFormatter.stringFromDate(sender.date)
    }
    func handleDatePicker2(sender: UIDatePicker) {
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .NoStyle
        timeFormatter.timeStyle = .ShortStyle
        endTime.text = timeFormatter.stringFromDate(sender.date)
        
    }
    
    
    @IBAction func endTimeEntered(sender: UITextField) {
        
        endPickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = endPickerView
        endPickerView.backgroundColor = UIColor(red: CGFloat(0.984), green: CGFloat(0.922), blue: CGFloat(0.831), alpha: 1.0)
        endPickerView.addTarget(self, action: Selector("handleDatePicker2:"), forControlEvents: UIControlEvents.AllEvents)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
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
