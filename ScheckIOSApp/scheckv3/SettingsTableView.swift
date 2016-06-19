//
//  SettingsTableView.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 2/27/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData
class SettingsTableView: UIViewController {
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var name = ""
    var emailC = ""
    var id = ""
    @IBOutlet weak var stepper2: UIStepper!
    @IBOutlet weak var stepper1: UIStepper!
    var companyItems = [CompanySettings]()
    var initialEmail : String = ""
    var changeCheck : Bool = false
    @IBOutlet var full: UILabel!
    @IBOutlet var part: UILabel!
    @IBOutlet var email: UITextField!
    @IBAction func saveButton(sender: AnyObject) {
        if email.text.isEmpty {
            var alert =
            UIAlertController(
                title: "Please enter a valid E-Mail Address",
                message: "",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if stepper2.value > stepper1.value{
            var alert =
            UIAlertController(
                title: "Part time hours cannot be longer than full time hours",
                message: "",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            
            fetchLog()
            
                let logItemToDelete = companyItems[0]
                let password = logItemToDelete.password
            
                managedObjectContext?.deleteObject(logItemToDelete)
                self.fetchLog()
                self.saveNewItem("", companyName: "", startTime: full.text!, endTime: part.text!, companyEmail: email.text, password: password)
                var alert =
                UIAlertController(
                    title: "Information Saved",
                    message: "",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)
                

            
            initialEmail = email.text
            changeCheck = false
        }
    }
    @IBAction func fullStepper(sender: UIStepper) {
        full.text = Int(sender.value).description
        changeCheck = true
    }
    @IBAction func partStepper(sender: UIStepper) {
        part.text = Int(sender.value).description
        changeCheck = true
    }
    //    @IBOutlet var fullTimeLabel: UILabel!
    //    @IBAction func fullTimeStepper(sender: UIStepper) {
    //        fullTimeLabel.text = Int(sender.value).description
    //    }
    //    @IBOutlet var partTimeLabel: UILabel!
    //    @IBAction func partTimeStepper(sender: UIStepper) {
    //        partTimeLabel.text = Int(sender.value).description
    //    }
    //
    //    @IBOutlet var email: UITextField!
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "CompanySettings")
        let sortDescriptor = NSSortDescriptor(key: "companyID", ascending: true)
        fetchRequest.sortDescriptors=[sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [CompanySettings] {
            companyItems = fetchResults
        }
    }
    
    @IBAction func callButton(sender: AnyObject) {
        
        let phone = "tel://6465746050";
        let url:NSURL = NSURL(string:phone)!;
         UIApplication.sharedApplication().openURL(url);
    }
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    func saveNewItem(companyID : String, companyName : String, startTime : String, endTime : String, companyEmail : String, password : String) {
        // Create the new  log item
        var newLogItem = CompanySettings.createInManagedObjectContext(self.managedObjectContext!, companyID : companyID, companyName : companyName, fullTime : startTime, partTime : endTime, companyEmail : companyEmail, password : password)
        
        // Update the array containing the table view row data
        self.fetchLog()
        save()
        
    }
    
    //    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
    //        return 4
    //    }
    //
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        var kCellIdentifier: String
    //        let identifiers = ["Full-time", "Part-time", "My E-Mail","Help"]
    //        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
    //
    //        kCellIdentifier = identifiers[indexPath.row]
    //
    //        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
    //        cell.textLabel?.text = kCellIdentifier
    //        cell.imageView?.image = UIImage(named: (kCellIdentifier + ".jpg"))
    //        return cell
    //    }
    
//    override func didMoveToParentViewController(parent: UIViewController?) {
//        var alert = UIAlertController(title: "Warning", message: "Changes not saved. Exit without saving?.", preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
//        //{ (action) -> Void in
//        self.presentViewController(alert, animated: true, completion: nil)
//        
//        
//    }
    
    
    func back (sender: UIBarButtonItem) {
        
        if changeCheck == true || email.text != initialEmail {
        var alert = UIAlertController(title: "Warning", message: "Changes not saved. Exit without saving?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: { (action)-> Void in
                self.navigationController?.popViewControllerAnimated(true) } ))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCheck = false
        initialEmail = email.text
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = backButton
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        self.fetchLog()
        var i : Int = 0
        full.text = "0"
        part.text = "0"
        email.text = self.emailC
        while (i < companyItems.count) {
            if ( companyItems[i].companyEmail.caseInsensitiveCompare(self.emailC) == NSComparisonResult.OrderedSame && companyItems[i].companyID.caseInsensitiveCompare(self.id) == NSComparisonResult.OrderedSame) {
                full.text = companyItems[i].fullTime
                part.text = companyItems[i].partTime
                email.text = companyItems[i].companyEmail
                stepper1.value = Double(companyItems[i].fullTime.toInt()!)
                stepper2.value = Double(companyItems[i].partTime.toInt()!)

                break
            }
            i++
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
