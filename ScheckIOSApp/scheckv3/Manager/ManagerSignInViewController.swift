//
//  SignInViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/14/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class ManagerSignInViewController: UIViewController {
    var empItems = [CompanySettings]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var name : String = ""
    var email : String = ""
    var id: String = ""
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func testButtonPlsIgnore(sender: UIButton) {
        saveNewItem("1", companyName: "scheck", startTime:
            "40", endTime: "36", companyEmail: "", password:"")
        log.debug("Debugging test")
        log.error("Error test")
        log.info("Info test")
        log.severe("Severe test")
        log.verbose("Verbose test")
        log.warning("Warning test")
        log.xcodeColorsEnabled = true
    }
    
    @IBAction func signIn(sender: AnyObject) {
        
        fetchLog()
        if (empItems.count == 0) {
            var alert =
            UIAlertController(
                title: "Warning",
                message: "No such email ID in database",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (authenticationValid()) {
            
            self.performSegueWithIdentifier( "signInSegue", sender: self)
        }
        else {
            var alert =
            UIAlertController(
                title: "Warning",
                message: "Incorrect Password",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    func authenticationValid() -> Bool {
        var i : Int = 0
        while (i < empItems.count) {
            if (empItems[i].companyEmail.caseInsensitiveCompare(emailTextField.text) == NSComparisonResult.OrderedSame) {
                if (empItems[i].password.caseInsensitiveCompare(passwordTextField.text) == NSComparisonResult.OrderedSame) {
                    name = empItems[i].companyName
                    email = empItems[i].companyEmail
                    id = empItems[i].companyID
                    return true
                }
                else {
                    return false
                }
            }
            i++
        }
        var alert =
        UIAlertController(
            title: "Warning",
            message: "No such email ID in database",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: nil
            ))
        self.presentViewController(alert, animated: true, completion: nil)
        
        return false
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "signInSegue") {
            println("Name sending is : " + self.name)
            println("Email sent is : " + self.email)
            println("ID sent is : " + self.id)
            let destination = segue.destinationViewController as! ContainerViewController
            destination.name = self.name
            destination.email = self.email
            destination.id = self.id
            destination.password = self.passwordTextField.text
        }
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "CompanySettings")
        //let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [CompanySettings] {
            empItems = fetchResults
        }
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
