//
//  EmployeeEditInfoViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/15/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData

class EmployeeEditInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var idLabel: UILabel!

    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    var name : String = ""
    var email : String = ""
    var password : String = ""
    var id : String = ""
    var empItems = [Employees]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBAction func donePressed(sender: AnyObject) {
      
        if (nameTextField.text != name || emailTextField.text != email) {
            if (passwordTextField.text != password ) {
                var alert =
                UIAlertController(
                    title: "Warning",
                    message: "Please enter correct old password to make any changes",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                if (newPasswordTextField.text.isEmpty && confirmPasswordTextField.text.isEmpty) {
                    fetchLog()
                    let dep = empItems[0].department
                    let managerEmail = empItems[0].managerEmail
                    managedObjectContext?.deleteObject(empItems[0]);
                    saveNewItem(id, email: emailTextField.text, name: nameTextField.text, password: newPasswordTextField.text, department: dep, mEmail: managerEmail)
                    if let navController = self.navigationController {
                        navController.popViewControllerAnimated(true) }
                    
                }
                else {
                    if (newPasswordTextField.text != confirmPasswordTextField.text) {
                        var alert =
                        UIAlertController(
                            title: "Warning",
                            message: "Please enter correct old password to make any changes",
                            preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                            handler: nil
                            ))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else {
                        fetchLog()
                        let dep = empItems[0].department
                        let managerEmail = empItems[0].managerEmail
                        managedObjectContext?.deleteObject(empItems[0]);
                        saveNewItem(id, email: emailTextField.text, name: nameTextField.text, password: newPasswordTextField.text, department: dep, mEmail: managerEmail)
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true) }
                    }
                }
            }
        }
        else {
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true) }
            
        }
    }
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    override func viewWillAppear(animated : Bool) {
        super.viewWillAppear(animated)
        fetchLog()
    }

    func saveNewItem(id : String, email : String, name : String, password : String, department : String, mEmail : String) {
        // Create the new  log item
        var newLogItem = Employees.createInManagedObjectContext(self.managedObjectContext!, id : id, email : email, name : name, department: department, password : password, hours : "0", managerEmail : mEmail )
        save()
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
    @IBAction func cancelPressed(sender: AnyObject) {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true) }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.text = name
        emailTextField.text = email
        idLabel.text = "ID: " + self.id
        self.confirmPasswordTextField.delegate = self;
        self.passwordTextField.delegate = self;
        self.nameTextField.delegate = self;
        self.emailTextField.delegate = self;
        self.newPasswordTextField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        for subview in self.view.subviews
        {
            if (subview.isKindOfClass(UITextField))
            {
                var textField = subview as! UITextField
                textField.addTarget(self, action: "textFieldDidReturn:", forControlEvents: UIControlEvents.EditingDidEndOnExit)
                
                textField.addTarget(self, action: "textFieldDidBeginEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var kPreferredTextFieldToKeyboardOffset: CGFloat = 250
    var keyboardFrame: CGRect = CGRect.nullRect
    var keyboardIsShowing: Bool = false
    weak var activeTextField: UITextField?
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        self.keyboardIsShowing = true
        
        if let info = notification.userInfo {
            self.keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            self.arrangeViewOffsetFromKeyboard()
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        self.keyboardIsShowing = false
        
        self.returnViewToInitialFrame()
    }
    
    func arrangeViewOffsetFromKeyboard()
    {
        var theApp: UIApplication = UIApplication.sharedApplication()
        var windowView: UIView? = theApp.delegate!.window!
        
        var textFieldLowerPoint: CGPoint = CGPointMake(self.activeTextField!.frame.origin.x, self.activeTextField!.frame.origin.y + self.activeTextField!.frame.size.height)
        
        var convertedTextFieldLowerPoint: CGPoint = self.view.convertPoint(textFieldLowerPoint, toView: windowView)
        
        var targetTextFieldLowerPoint: CGPoint = CGPointMake(self.activeTextField!.frame.origin.x, self.keyboardFrame.origin.y - kPreferredTextFieldToKeyboardOffset)
        
        var targetPointOffset: CGFloat = targetTextFieldLowerPoint.y - convertedTextFieldLowerPoint.y
        var adjustedViewFrameCenter: CGPoint = CGPointMake(self.view.center.x, self.view.center.y + targetPointOffset)
        
        UIView.animateWithDuration(0.2, animations:  {
            self.view.center = adjustedViewFrameCenter
        })
    }
    
    func returnViewToInitialFrame()
    {
        var initialViewRect: CGRect = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
        
        if (!CGRectEqualToRect(initialViewRect, self.view.frame))
        {
            UIView.animateWithDuration(0.2, animations: {
                self.view.frame = initialViewRect
            });
        }
    }
    
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
//    {
//        if (self.activeTextField != nil)
//        {
//            self.activeTextField?.resignFirstResponder()
//            self.activeTextField = nil
//        }
//    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            // ...
                    if (self.activeTextField != nil)
                    {
                        self.activeTextField?.resignFirstResponder()
                        self.activeTextField = nil
                    }
            
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    @IBAction func textFieldDidReturn(textField: UITextField!)
    {
        textField.resignFirstResponder()
        self.activeTextField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.activeTextField = textField
        
        if(self.keyboardIsShowing)
        {
            self.arrangeViewOffsetFromKeyboard()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.nameTextField) {
            
            self.emailTextField.becomeFirstResponder();
        }
        else if (textField == self.emailTextField) {
            
            self.passwordTextField.becomeFirstResponder();
        }
        else if (textField == self.passwordTextField) {
            
            self.newPasswordTextField.becomeFirstResponder()
        }
        else if (textField == self.newPasswordTextField) {
            
            self.confirmPasswordTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true;
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
