//
//  ActivityTableViewCell.swift
//  iPark
//
//  Created by Jade Hennebert on 23/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class ActiviteCell: UITableViewCell {

    @IBOutlet weak var activityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
