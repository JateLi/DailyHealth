//
//  CustomViewCell.swift
//  DailyHealth
//
//  Created by Tengzhe Li on 13/05/18.
//  Copyright © 2018 Tengzhe Li. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var NameOfHabit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
