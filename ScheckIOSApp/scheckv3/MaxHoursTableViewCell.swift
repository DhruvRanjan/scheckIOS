//
//  MaxHoursTableViewCell.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 2/27/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class MaxHoursTableViewCell: UITableViewCell {

    
    @IBOutlet var Hours: UILabel!
    @IBOutlet var hoursStepper: UIStepper!
    @IBAction func hoursStepper(sender: UIStepper) {
        self.Hours.text = Int(sender.value).description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Hours.text = "40"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
