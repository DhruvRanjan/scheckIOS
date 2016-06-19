//
//  EmployeeMakeRequestViewController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 4/15/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class EmployeeMakeRequestViewController: UIViewController {

    @IBOutlet var doneButton: UIButton!
    var dayPicker : UIDatePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.enabled = false
        doneButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dayTextFieldPressed(sender: UITextField) {
//        dayPicker.datePickerMode = UIDatePickerMode.
        
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
