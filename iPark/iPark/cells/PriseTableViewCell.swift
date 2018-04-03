//
//  File.swift
//  iPark
//
//  Created by Johan BRUNET on 03/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class PriseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var heure: UILabel!
    @IBOutlet weak var medicament: UILabel!
    @IBOutlet weak var imageEtat: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
