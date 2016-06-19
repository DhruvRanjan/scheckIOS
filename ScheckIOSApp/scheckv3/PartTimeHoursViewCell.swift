//
//  PartTimeHoursViewCell.swift
//  scheckv3
//
//  Created by Dhruv Ranjan, Kunal Thacker on 2/27/15.
//  Copyright (c) 2015 scheck. All rights reserved.
//

import UIKit

class PartTimeHoursViewCell: UITableViewCell {

    @IBOutlet var Hours: UILabel!
    @IBAction func partTimeHours(sender: UIStepper) {
        Hours.text = Int(sender.value).description
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Hours.text = "36"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
