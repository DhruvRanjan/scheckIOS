//
//  SignInViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/14/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData
class SignInViewController: UIViewController {
    var empItems = [Employees]()
    
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
        else if (empItems[0].password == passwordTextField.text) {
            name = empItems[0].name
            email = empItems[0].email
            id = empItems[0].id
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "signInSegue") {
            
        let destination = segue.destinationViewController as! EmployeeHomeViewController
        destination.name = self.name
        destination.email = self.email
        destination.id = self.id
        destination.password = self.passwordTextField.text
        }
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "email", ascending: true)
        //let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "(email = %@)", emailTextField.text)
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
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
