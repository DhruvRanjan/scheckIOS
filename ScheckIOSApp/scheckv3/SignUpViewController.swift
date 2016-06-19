//
//  SignUpViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/14/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import CoreData
class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var empItems = [Employees]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var idTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var cpasswordTextField: UITextField!
    
    @IBOutlet var companyTextField: UITextField!
    @IBAction func doneButton(sender: AnyObject) {
        if (nameTextField.text.isEmpty || emailTextField.text.isEmpty ||
            idTextField.text.isEmpty ||
            companyTextField.text.isEmpty ||
            passwordTextField.text.isEmpty ||
            cpasswordTextField.text.isEmpty) {
                var alert =
                UIAlertController(
                    title: "Warning",
                    message: "One of the text fields is empty",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (passwordTextField.text != (cpasswordTextField.text) ) {
            var alert =
            UIAlertController(
                title: "Warning",
                message: "Passwords do not match",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (passwordTooWeak(passwordTextField.text!)) {
            var alert =
            UIAlertController(
                title: "Password too weak",
                message: "Passwords length must be between 6 and 16, must contain at least one alphabet and one number",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (emailInvalid(emailTextField.text!)) {
            var alert =
            UIAlertController(
                title: "Invalid email",
                message: "The email address you input is invalid, please enter a valid and working email",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if hasSignedUp(idTextField.text) {
            var alert =
            UIAlertController(
                title: "Invalid id",
                message: "The person with the given id has already signed up for the company!",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            fetchLog();
            if empItems.count == 0 {
                var alert =
                UIAlertController(
                    title: "Warning",
                    message: "This ID does not exist",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)            }
            else {
                var dep = empItems[0].department
                var managerEmail = empItems[0].managerEmail
                managedObjectContext?.deleteObject(empItems[0])
                saveNewItem(idTextField.text, email: emailTextField.text, name: nameTextField.text, department: dep, password: passwordTextField.text, managerEmail : managerEmail)
                fetchLog()
                
            }
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true) }
        }
    }
    
    @IBOutlet weak var isLoading: UIActivityIndicatorView!
    
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
//        isLoading.hidden = false
//        while (isCompleted == false) {
//            isLoading.startAnimating()
//        }
//        isLoading.stopAnimating()
//        isLoading.hidden = true
//        return invalid
        return false
    }
    
    func hasSignedUp(String) -> Bool {
        fetchLog()
        if empItems.count == 0 {
            return false
        }
        else if empItems[0].password.isEmpty {
            return false
        }
        return true
        
    }
    
    func passwordTooWeak(password : String)  -> Bool {
        if (count(password) < 6) {
            return true
        }
        if (count(password) > 16) {
            return true
        }
        let letters = NSCharacterSet.letterCharacterSet()
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        
        
        var letterCount = 0
        var digitCount = 0
        for uni in password.unicodeScalars {
            if letters.longCharacterIsMember(uni.value) {
                letterCount++
            } else if digits.longCharacterIsMember(uni.value) {
                digitCount++
            }
        }
        if (letterCount == 0 || digitCount == 0 ) {
            return true
        }
        
        return false
    }
    func save(){
        var error: NSError?
        if(managedObjectContext!.save(&error)) {
            
        }
    }
    
    func saveNewItem(id : String, email : String, name : String, department : String, password : String, managerEmail : String) {
        // Create the new  log item
        var newLogItem = Employees.createInManagedObjectContext(self.managedObjectContext!, id : id, email : email, name : name, department: department, password : password, hours: "0", managerEmail: managerEmail)
        save()
    }
    
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Employees")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        //let tableArray = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        let pred = NSPredicate(format: "(id = %@)", idTextField.text)
        fetchRequest.sortDescriptors=[sortDescriptor]
        fetchRequest.predicate = pred
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Employees] {
            empItems = fetchResults
        }
    }
    
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBAction func cancelButton(sender: AnyObject) {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true) }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoading.hidden = true
        // Do any additional setup after loading the view.
        self.cpasswordTextField.delegate = self;
        self.passwordTextField.delegate = self;
        self.idTextField.delegate = self;
        self.nameTextField.delegate = self;
        self.emailTextField.delegate = self;
        self.companyTextField.delegate = self;
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
    var kPreferredTextFieldToKeyboardOffset: CGFloat = 200
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
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.nameTextField) {
            self.emailTextField.becomeFirstResponder();
        }
        else if (textField == self.emailTextField) {
            self.idTextField.becomeFirstResponder();
        }
        else if (textField == self.idTextField) {
            self.companyTextField.becomeFirstResponder()
        }
        else if (textField == self.companyTextField) {
            self.passwordTextField.becomeFirstResponder()
        }
        else if (textField == self.passwordTextField) {
            self.cpasswordTextField.becomeFirstResponder();
        }
        else {
            textField.resignFirstResponder()
        }
        return true;
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


