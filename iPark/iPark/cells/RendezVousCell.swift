//
//  RendezVousCell.swift
//  iPark
//
//  Created by Johan BRUNET on 27/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import UIKit

class RendezVousCell: UITableViewCell {
    
    @IBOutlet weak var nomMedecin: UILabel!
    @IBOutlet weak var specialiteMedecin: UILabel!
    @IBOutlet weak var dateRDV: UILabel!
    @IBOutlet weak var heureRDV: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
