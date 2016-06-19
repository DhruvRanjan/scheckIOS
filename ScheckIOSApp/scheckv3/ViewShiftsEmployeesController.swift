//
//  ViewShiftsEmployeesController.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 3/30/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class ViewShiftsEmployeesController: UIViewController, UITableViewDataSource, UITableViewDelegate {

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let kCellIdentifier: String = "name"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        // let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = "name"
        //        switch indexPath.row {
        //        case 0:
        //            cell.textLabel?.text = "Kunal"
        //
        //        case 1:
        //            cell.textLabel?.text = "Alex"
        //        case 2:
        //            cell.textLabel?.text = "Dhruv"
        //        case 3:
        //            cell.textLabel?.text = "Dhruv2"
        //        default:
        //            cell.textLabel?.text = "Error"
        //        }
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
