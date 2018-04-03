//
//  NewMedicationRappelViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 02/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class NewMedicationRappelViewController: UIViewController {
    
    var medicament: Medicament? = nil
    var dose: String? = nil
    var quantite: String? = nil
    
    @IBOutlet weak var heurePrise: UIDatePicker!
    @IBOutlet weak var finTraitement: UIDatePicker!
    var newPrises: [Prise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitForm(_ sender: Any) {
        let prise: Date = DateHelper.changeHour(date: Date(), heureMin: self.heurePrise.date)
        let rappel: Date = DateHelper.changeHour(date: self.finTraitement.date, heureMin: self.heurePrise.date)
        let datesRappels: [Date] = DateHelper.getDates(dateD: prise, dateF: rappel)
        for dr in datesRappels {
            let np = Prise(forMed: self.medicament!, withDose: self.dose!, withQuant: Int(self.quantite!)!, at: dr)
            self.newPrises.append(np)
            self.ajouterNotif(np)
        }
        self.performSegue(withIdentifier: "showPilulier", sender: self)
    }
    
    func ajouterNotif(_ prise: Prise) {
        let notifID: String = prise.med.nom + DateHelper.formatDate(date: prise.rappelPrise, pattern: "ddMMyyyyHHmm")
        let notifTitle: String = "Prise de médicament"
        let notifBody: String =  "Il est l'heure de prendre vos " + prise.quantiteMed.description + " comprimés de " + prise.med.nom + " " + prise.doseMed
        AppDelegate.notification.addNotification(identifier: notifID, title: notifTitle, body: notifBody, date: DateHelper.removeSeconds(from: prise.rappelPrise))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PillsViewController
        for p in self.newPrises {
            destinationVC.medications?.add(p)
        }
    }
}
