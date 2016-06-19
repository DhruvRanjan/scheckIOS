//
//  AddEmployeeViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/20/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData


class AddEmployeeViewController: UIViewController {
    
    var depVar : String = ""
    var mEmail : String = ""
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var employeeItems = [Employees]()

    
//    @IBOutlet var id : UITextField!
//    @IBOutlet var name : UITextField!
//    @IBOutlet var email : UITextField!
//    @IBAction func doneButton(sender: AddEmployeeViewController) {
//        
//        self.saveNewItem(self.id.text, email: self.email.text, name: self.name.text, department: depVar)
//        if let navController = self.navigationController {
//            navController.popViewControllerAnimated(true) }
//    }
    
    
    @IBOutlet var id: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!

    @IBAction func doneButton2(sender: AnyObject) {
        if id.text.isEmpty {
            var alert = UIAlertController(title: "Please enter a valid ID", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if checkForDuplicateID(id.text) == false {
            var alert = UIAlertController(title: "ID already exists. Please enter different ID", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if checkForDuplicateEmails(email.text)==false {
            var alert = UIAlertController(title: "Email already exists. Please enter different Email Address", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if emailInvalid(email.text) {
            var alert = UIAlertController(title: "Please enter a valid email address, or none at all", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            self.saveNewItem(self.id.text, email: self.email.text, name: self.name.text)
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true) }
        }
    }
    func emailInvalid(email : String) -> Bool {
//        println("Log.SignUpViewController.swift : Started email validity check")
//        let username : String = "scheckdeveloper"
//        let password : String = "5357beeler"
//        let api_url : String = "http://api.verify-email.org/api.php?"
//        let url : String = api_url + "usr=" + username + "&pwd=" + password + "&check=" + email
//        
//        let nurl : NSURL = NSURL(string: url)!
//        println("Log.SignupViewController.swift : URL = " + nurl.description)
//        var invalid : Bool = true
//        var isCompleted : Bool = false
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(nurl, completionHandler: {data, response, error -> Void in
//            
//            if error != nil {
//                // If there is an error in the web request, print it to the console
//                println(error.localizedDescription)
//            }
//            
//            var err: NSError?
//            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
//            if err != nil {
//                // If there is an error parsing JSON, print it to the console
//                println("JSON Error \(err!.localizedDescription)")
//            }
//            
//            println(jsonResult)
//            println(jsonResult["verify_status"]! as! NSInteger)
//            println("Log.SignUpViewController.swift : Ended email validity check")
//            if (jsonResult["verify_status"]! as! NSInteger == 0) {
//                println("Log.SignUpViewController.swift : invalid is true")
//                invalid = true
//            }
//            else {
//                println("Log.SignUpViewController.swift : invalid is false")
//                invalid = false
//            }
//            isCompleted = true
//            
//        })
//        task.resume()
//        
//        while (isCompleted == false) {
//        }
       return false
//        return invalid
    }
    func checkForDuplicateID(id : String) -> Bool {
        
        fetchLog()
        for i in employeeItems{
            if i.id == id {
                return false
            }
        }
        return true
    }
    
    func checkForDuplicateEmails(email : String) -> Bool{
        
        fetchLog()
        if (email.isEmpty) {
            return true
        }
        
        for i in employeeItems{
            if i.email == email {
                return false
            }
        }
        return true
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let pred2 = NSPredicate(format: "(managerEmail = %@)", mEmail)
        
        fetchRequest.predicate = pred2
        fetchRequest.sortDescriptors=[sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
            employeeItems = fetchResults
        }
    }
    
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    func saveNewItem(id : String, email : String, name : String) {
        // Create the new  log item
        var newLogItem = Employees.createInManagedObjectContext(self.managedObjectContext!, id : id, email : email, name : name, department : depVar, password : "", hours : "0", managerEmail : self.mEmail)
        save()
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
