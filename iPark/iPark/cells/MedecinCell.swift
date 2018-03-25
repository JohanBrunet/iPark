//
//  MedecinCell.swift
//  iPark
//
//  Created by Johan BRUNET on 24/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class MedecinCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var specialty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

