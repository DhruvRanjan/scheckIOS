//
//  EmployeeMyInfoViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/15/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class EmployeeMyInfoViewController: UIViewController {

    @IBOutlet var idLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var empItems = [Employees]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var name : String = ""
    var email : String = ""
    var id : String = ""
    var password : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchLog()
        idLabel.text = empItems[0].id
        nameLabel.text = empItems[0].name
        emailLabel.text = empItems[0].email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editInfo") {
            
            let destination = segue.destinationViewController as! EmployeeEditInfoViewController
            destination.name = self.name
            destination.email = self.email
            destination.password = self.password
            destination.id = self.id
        }
        else {
            let destination = segue.destinationViewController as! AvailabilityViewController
            destination.id = self.id
        }
    
        
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchLog()
        idLabel.text = empItems[0].id
        nameLabel.text = empItems[0].name
        emailLabel.text = empItems[0].email
        self.password = empItems[0].password
        self.name = empItems[0].name
        self.email = empItems[0].email
        
    }
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        //let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "(id = %@)", id)
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
            empItems = fetchResults
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
