//
//  MyAppointmentViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class MyAppointmentViewController:UIViewController{
    
    
    @IBOutlet weak var specialiteMedecinLabel: UILabel!
    @IBOutlet weak var medecinLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var dateRDVLabel: UILabel!
    @IBOutlet weak var rappelLabel: UILabel!
    var rdv: RendezVous? = nil
    
    override func viewDidLoad() {
        let med: Medecin = (self.rdv?.med)!
        self.specialiteMedecinLabel.text = med.spe?.label
        self.medecinLabel.text = med.titledName
        self.adresseLabel.text = med.adr
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        // Apply date format
        dateFormatter.dateFormat = "EEEE dd MMMM yyyy à HH:mm"
        let dateRDVFormatted = dateFormatter.string(from: (self.rdv?.dateRDV)!)
        
        self.dateRDVLabel.text = dateRDVFormatted
        
        if let rappel = self.rdv?.rappelRDV {
            let timeToSubstract = -(rappel.timeIntervalSince1970)
            let tempsPrep = self.rdv?.dateRDV.addingTimeInterval(timeToSubstract)
            dateFormatter.dateFormat = "HH"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            let heures = dateFormatter.string(from: tempsPrep!)
            dateFormatter.dateFormat = "mm"
            let minutes = dateFormatter.string(from: tempsPrep!)
            self.rappelLabel.text = heures + "h" + minutes + "min avant"
        }
        else {
            self.rappelLabel.text = "Pas de rappel pour ce rendez-vous"
        }
    }
}
