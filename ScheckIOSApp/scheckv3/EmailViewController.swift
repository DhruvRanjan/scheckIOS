//
//  EmailViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/17/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var subject: UITextField!
    @IBOutlet var body: UITextView!
    var emailVar : String = "Hey"
    @IBAction func sendMail(sender: AnyObject) {
        var picker = MFMailComposeViewController()
        var recipients = [String]()
        recipients.append(emailVar)
        picker.mailComposeDelegate = self
        picker.setSubject(subject.text)
        picker.setMessageBody(body.text, isHTML: true)
        picker.setToRecipients(recipients)
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var emailID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (255.0/255.0), green: (140.0/255.0), blue: 0.0, alpha: 1.0)
        subject.delegate = self
        body.delegate = self
        println("hellllllo")
        println(emailVar)
        emailID.text = emailVar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MFMailComposeViewControllerDelegate
    
    // 1
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // UITextFieldDelegate
    
    // 2
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // UITextViewDelegate
    
    // 3
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        body.text = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }
}
