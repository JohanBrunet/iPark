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
    var lastRDV: RendezVous? = nil
    
    override func viewDidLoad() {
        let rdvs: RendezVousSet = RendezVousSet(from: CoreDataDAOFactory.getInstance().getRendezVousDAO().getAll()!)
        let filteredSetMed = rdvs.filterByMedecin(for: self.medecin!)
        if filteredSetMed.count > 0 {
            let filteredSetDate = filteredSetMed.filterByDate(for: Date(), before: true)
            if filteredSetDate.count > 0 {
                filteredSetDate.sortByDate()
                self.lastRDV = filteredSetDate.get(filteredSetDate.count - 1)
                // Create date formatter
                let dateFormatter: DateFormatter = DateFormatter()
                
                // Set date format
                dateFormatter.locale = Locale(identifier: "fr_FR")
                dateFormatter.timeZone = NSTimeZone(name: "UTC+1") as TimeZone!
                
                dateFormatter.dateFormat = "EEEE dd MMM yyyy"
                // Apply date format
                let dateRDV = dateFormatter.string(from: (self.lastRDV?.dateRDV)!)
                
                // Change date format
                dateFormatter.dateFormat = "HH:mm"
                let heureRDV = dateFormatter.string(from: (self.lastRDV?.dateRDV)!)
                
                self.lastAppointment.text = dateRDV + " à " + heureRDV
            }
            else {
                self.lastAppointment.text = "Pas de rendez-vous précédent"
            }
        }
        else {
            self.lastAppointment.text = "Pas de rendez-vous précédent"
        }
        
        self.titledName.text = medecin?.titledName
        self.adress.text = medecin?.adr
        if (medecin?.spe) != nil {
            self.specialty.text = medecin?.spe?.libelle
        }
        else {
            self.specialty.text = "Non renseigné"
        }
        self.phoneNumber.text = medecin?.tel
    }
    
    @IBAction func deleteMedecin(_ sender: Any) {
        self.performSegue(withIdentifier: "showPatientInfos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PersonalInfoViewController
        destinationVC.medecins?.remove(medecin!)
    }
}
