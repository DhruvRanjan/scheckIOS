//
//  HelpCell.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 2/27/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class HelpCell: UITableViewCell {

    @IBAction func callButton(sender: AnyObject) {
//        if let url = NSURL(string: "tel://\(6465746050)") {
//            UIApplication.sharedApplication().openURL(url)
//        }

        let phone = "tel://6465746050";
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
