//
//  DoctorViewController.swift
//  iPark
//
//  Created by Jade Hennebert on 21/03/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class DoctorViewController: UIViewController {

    
    
    @IBOutlet weak var titledName: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var lastAppointment: UILabel!
    @IBOutlet weak var specialty: UILabel!
    var medecin: Medecin? = nil
    var posMedecin: Int? = nil
    
    override func viewDidLoad() {
        let rdvs: RendezVousSet = RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!)
        
        self.titledName.text = medecin?.titledName
        self.adress.text = medecin?.adr
        if (medecin?.spe) != nil {
            self.specialty.text = medecin?.spe?.libelle
        }
        else {
            self.specialty.text = "Non renseigné"
        }
        self.phoneNumber.text = medecin?.tel
        
        guard let lastRDVForMed = rdvs.getLastForMed(for: self.medecin!) else {
            self.lastAppointment.text = "Pas de rendez-vous précédent"
            return
        }
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.timeZone = NSTimeZone(name: "UTC+1") as TimeZone!
        
        // Apply date format
        dateFormatter.dateFormat = "EEEE dd MMMM yyyy à HH:mm"
        let dateRDVFormatted = dateFormatter.string(from: (lastRDVForMed.dateRDV))
        self.lastAppointment.text = dateRDVFormatted
    }
    
    @IBAction func deleteMedecin(_ sender: Any) {
        self.performSegue(withIdentifier: "showPatientInfos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PersonalInfoViewController
        destinationVC.medecins?.remove(medecin!)
    }
}
