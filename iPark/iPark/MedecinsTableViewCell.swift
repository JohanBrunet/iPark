//
//  MedecinsTableViewCell.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class MedecinsTableViewCell: UITableViewCell {

    @IBOutlet weak var DoctorNameLabel: UILabel!
    @IBOutlet weak var SpecialiteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
