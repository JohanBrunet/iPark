//
//  ReporterPriseViewController.swift
//  iPark
//
//  Created by Johan BRUNET on 04/04/2018.
//  Copyright © 2018 Jade HENNEBERT. All rights reserved.
//

import Foundation
import UIKit

class ReporterPriseViewController: UIViewController {
    
    @IBOutlet weak var heureDecalagePrise: UIDatePicker!
    
    var priseAReporter: Prise? = nil
    var newPrise: Prise? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heureDecalagePrise.countDownDuration = 0
        self.heureDecalagePrise.locale = Locale(identifier: "fr_FR")
    }

    @IBAction func reporterPrise(_ sender: Any) {
        let tempsPrep = self.heureDecalagePrise.countDownDuration
        let nouveauRappel = self.priseAReporter?.rappelPrise.addingTimeInterval(tempsPrep)
        self.newPrise = Prise(forMed: (self.priseAReporter?.med)!, withDose: (self.priseAReporter?.doseMed)!, withQuant: (self.priseAReporter?.quantiteMed)!, at: nouveauRappel!)
        self.ajouterNotif()
        self.performSegue(withIdentifier: "decalerPrise", sender: self)
    }
    
    func ajouterNotif() {
        let notifID: String = self.newPrise!.med.nom + DateHelper.formatDate(date: self.newPrise!.rappelPrise, pattern: "ddMMyyyyHHmm")
        let notifTitle: String = "Prise de médicament"
        let notifBody: String =  "Il est l'heure de prendre vos " + self.newPrise!.quantiteMed.description + " comprimés de " + self.newPrise!.med.nom + " " + self.newPrise!.doseMed
        AppDelegate.notification.addNotification(identifier: notifID, title: notifTitle, body: notifBody, date: DateHelper.removeSeconds(from: (self.newPrise?.rappelPrise)!), repeatable: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PillsViewController
        destinationVC.medications?.add(self.newPrise!)
    }
    
}
