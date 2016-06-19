//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit



class SidePanelViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
    struct TableView {

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.backgroundColor = UIColor.lightGrayColor()
    self.view.backgroundColor = UIColor.lightGrayColor()
    tableView.reloadData()
  }
  
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let textLabels = ["About", "Legal", "", "Report Logs", "Clear cache"]
    let cell = tableView.dequeueReusableCellWithIdentifier("aboutCell") as! UITableViewCell
  
    cell.textLabel?.text = textLabels[indexPath.row]
    
    return cell
  }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 2) {
            return (44.0 * 8)
        }
        else { return 44.0}
    }
  
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
}


  